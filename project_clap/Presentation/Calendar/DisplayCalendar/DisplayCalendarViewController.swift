import Foundation
import UIKit
import RxSwift
import RxCocoa
import JTAppleCalendar
import CalculateCalendarLogic
import PopupDialog

class DisplayCalendarViewController: UIViewController {
    //階層構造をgetObjectFromServerが受け取れる形にする
    //階層構造 calendar 日付 events イベント(情報持)
    
    //Realmだと仮定
    let modalTransitionDelegate = ModalTransitionDelegate()
    private var recievedFromServer: [String: [String]] = [:]
    private let disposeBag = DisposeBag()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        return formatter
    }()
    
    private lazy var ui: DisplayCalendarUI = {
        let ui = DisplayCalendarUIImpl()
        ui.calendarView.calendarDelegate = self
        ui.calendarView.calendarDataSource = self
        ui.eventField.delegate = self
        ui.eventField.dataSource = self
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: DisplayCalendarRouting = {
        let routing = DisplayCalendarRoutingImpl()
        routing.viewController = self
        return routing
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.setupInsideDisplayCalendar(vc: self)
        setupCalendar()
        getCurrentDay()
        loadEventData()
        setupViewModel()
        //以下のapiはcalendar作業の時に移動させる
        //datastore移動
        Firebase.db.collection("users").document(UserSingleton.sharedInstance.uid).getDocument(completion: { (snapshot, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            guard let snapshot = snapshot, snapshot.exists, let data = snapshot.data() else { return }
            if let teamId = data["teamId"] as? String {
                //view.isUserInteractionEnabled必要　fetch中にdiaryページに行かせないため
                
                AppUserDefaults.setValue(value: teamId, keyName: "teamId")
            }
        })
    }
}

extension DisplayCalendarViewController {
    
    private func setupViewModel() {
        ui.eventAddBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.ui.eventAddBtn.bounce(completion: {
                    guard
                        let selectedDate = self?.ui.selectedDateToSendRegistPage,
                        let vc = self
                    else { return }
                    vc.routing.showRegistCalendar(date: selectedDate, modalTransion: vc.modalTransitionDelegate)
                })
            }).disposed(by: disposeBag)
    }
    
    private func setupCalendar() {
        ui.calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    private func getCurrentDay() {
        ui.calendarView.scrollToDate(Date(), animateScroll: false) {
            self.ui.calendarView.selectDates([Date()])
        }
    }
    
    private func loadEventData() {
        //firebaseから取得して、[string: [string]]に変換して、recievedFromServerに渡す
        Firebase.db.collection("calendar").document(AppUserDefaults.getValue(keyName: "teamId")).collection("events").addSnapshotListener { query, error in
            if let _ = error {
                return
            }
            
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            let recievedData = self.getObjectFromServer()
            for (date, event) in recievedData {
                let stringDate = self.formatter.string(from: date)
                self.recievedFromServer[stringDate] = event
            }
            DispatchQueue.main.async {
                self.ui.calendarView.reloadData()
            }
        }
    }
    
    private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else { return }
        formatter.dateFormat = "yyyy"
        ui.dateOfYear.text = self.formatter.string(from: date)
        self.formatter.dateFormat = "MMMM"
        ui.dateOfMonth.text = self.formatter.string(from: date)
    }
    
    private func handleCellTextColor(view: JTAppleCell?, cellState: CellState, date: Date) {
        guard let cell = view as? DisplayCalendarCell else { return }
        
        let todaysDate = Date()
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        let weekday = CalendarLogic.getWeekIdx(date)
        if weekday == DisplayCalendarResources.View.sunday {
            cell.stateOfDateAtCalendar.textColor = .red
        } else if weekday == DisplayCalendarResources.View.saturday {
            cell.stateOfDateAtCalendar.textColor = .blue
        } else {
            if CalendarLogic.judgeHoliday(date) {
                cell.stateOfDateAtCalendar.textColor = .red
            } else if cellState.dateBelongsTo == .thisMonth {
                if todaysDateString != monthDateString {
                    cell.stateOfDateAtCalendar.textColor = cellState.isSelected ? .white : .black
                } else {
                    cell.stateOfDateAtCalendar.textColor = .black
                }
            } else if cellState.dateBelongsTo == .previousMonthWithinBoundary {
                cell.stateOfDateAtCalendar.textColor = .gray
            } else if cellState.dateBelongsTo == .followingMonthWithinBoundary {
                cell.stateOfDateAtCalendar.textColor = .gray
            } else if cellState.dateBelongsTo == .previousMonthOutsideBoundary {
                cell.stateOfDateAtCalendar.textColor = .gray
            } else {
                cell.stateOfDateAtCalendar.textColor = .black
            }
        }
    }
    
    private func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DisplayCalendarCell else { return }
        if cellState.isSelected {
            cell.selectedDateMarker.isHidden = false
        } else {
            cell.selectedDateMarker.isHidden = true
        }
    }
    
    private func handleCellEvents(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DisplayCalendarCell else { return }
        cell.calendarEventDots.isHidden = !recievedFromServer.contains { $0.key == formatter.string(from: cellState.date) }
    }
    
    #warning("仮実装や")
    private func getObjectFromServer() -> [Date: [String]] {
        //年ごとにデータを取得してローカルDBにセット
        formatter.dateFormat = "yyyy MM dd"
        return [
            formatter.date(from: "2019 04 06")!: ["aaaaa"],
            formatter.date(from: "2019 04 05")!: ["bbbbb"],
            formatter.date(from: "2019 04 01")!: ["ccccc"],
            formatter.date(from: "2019 04 09")!: ["ddddd"],
            formatter.date(from: "2019 04 18")!: ["eeeee", "fffff"],
            formatter.date(from: "2019 04 21")!: ["eeeee", "fffff"],
            formatter.date(from: "2019 04 24")!: ["eeeee", "fffff", "eeeee", "fffff"],
            formatter.date(from: "2019 04 30")!: ["eeeee", "fffff"],
            formatter.date(from: "2019 04 02")!: ["eeeee", "fffff", "eeeee", "fffff"],
            formatter.date(from: "2019 04 23")!: ["eeeee", "fffff", "eeeee", "fffff", "eeeee", "fffff"],
        ]
    }
}

extension DisplayCalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        guard let startDate = formatter.date(from: "2019 01 01"), let endDate = formatter.date(from: "2100 12 31") else {
            return ConfigurationParameters(startDate: Date(), endDate: Date())
        }
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: false)
        return parameters
    }
}

extension DisplayCalendarViewController: JTAppleCalendarViewDelegate {

    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: String(describing: DisplayCalendarCell.self), for: indexPath) as? DisplayCalendarCell else { return JTAppleCell() }
        cell.configureInit(stateOfDateAtCalendar: cellState.text)
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState, date: date)
        handleCellEvents(view: cell, cellState: cellState)
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        ui.coloringCalendar(calendar: calendar,
                            cell: cell,
                            cellState: cellState,
                            indexPath: indexPath)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState, date: date)
        cell?.bounce()
        ui.selectedDateToSendRegistPage = date
        let stringDate = formatter.string(from: cellState.date)
        ui.selectedDayEvent = []
        for (date, events) in recievedFromServer {
            if date == stringDate {
                _ = events.map { event in
                    self.ui.selectedDayEvent.append(CalendarEvent(event: event))
                }
                ui.eventField.reloadData()
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState, date: date)
        ui.selectedDayEvent = []
        ui.eventField.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        if cellState.dateBelongsTo != .thisMonth {
            return false
        }
        return true
    }
}

extension DisplayCalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ui.configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ui.selectedDayEvent.count
    }
}

extension DisplayCalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
