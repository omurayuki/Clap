import Foundation
import UIKit
import RxSwift
import RxCocoa
import JTAppleCalendar
import CalculateCalendarLogic
import PopupDialog

class DisplayCalendarViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    //Realmだと仮定
    private var recievedFromServer: [String: [String]] = [:]
    private var selectedDayEvent: [CalendarEvent] = []
    private var selectedDateToSendRegistPage: Date = Date()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        return formatter
    }()
    
    private lazy var dateOfYear: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.dateOfYearFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateOfMonth: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.dateOfMonth
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var displayCalendarView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var sunday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.sunday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var monday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.monday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tuesday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.tuesday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var wednesday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.wednesday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var thursday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.thursday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var friday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.friday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var saturday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.saturday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var monthOfDayStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(sunday)
        stack.addArrangedSubview(monday)
        stack.addArrangedSubview(tuesday)
        stack.addArrangedSubview(wednesday)
        stack.addArrangedSubview(thursday)
        stack.addArrangedSubview(friday)
        stack.addArrangedSubview(saturday)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var calendarView: JTAppleCalendarView = {
        let calendar = JTAppleCalendarView()
        calendar.scrollingMode = .stopAtEachCalendarFrame
        calendar.showsHorizontalScrollIndicator = false
        calendar.showsVerticalScrollIndicator = false
        calendar.backgroundColor = .clear
        calendar.tintColor = .black
        calendar.scrollDirection = .horizontal
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self
        calendar.register(DisplayCalendarCell.self, forCellWithReuseIdentifier: String(describing: DisplayCalendarCell.self))
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    private lazy var eventField: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = AppResources.ColorResources.appCommonClearColor
        table.delegate = self
        table.dataSource = self
        table.rowHeight = DisplayCalendarResources.View.tableViewHeight
        table.register(DisplayEventCell.self, forCellReuseIdentifier: String(describing: DisplayEventCell.self))
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var eventAddBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInsideDisplayCalendar()
        setupCalendar()
        getCurrentDay()
        loadEventData()
        setupViewModel()
    }
}

extension DisplayCalendarViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = R.string.locarizable.calendar_title()
        view.addSubview(dateOfYear)
        dateOfYear.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateOfYear.leftAnchor.constraint(equalTo: view.leftAnchor, constant: DisplayCalendarResources.Constraint.dateOfYearLeftConstraint).isActive = true
        view.addSubview(dateOfMonth)
        dateOfMonth.topAnchor.constraint(equalTo: dateOfYear.bottomAnchor, constant: DisplayCalendarResources.Constraint.dateOfMonthTopConstraint).isActive = true
        dateOfMonth.leftAnchor.constraint(equalTo: view.leftAnchor, constant: DisplayCalendarResources.Constraint.dateOfMonthLeftConstraint).isActive = true
        view.addSubview(displayCalendarView)
        displayCalendarView.topAnchor.constraint(equalTo: dateOfMonth.bottomAnchor, constant: DisplayCalendarResources.Constraint.displayCalendarViewTopConstraint).isActive = true
        displayCalendarView.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 2).isActive = true
        displayCalendarView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        view.addSubview(eventField)
        eventField.topAnchor.constraint(equalTo: displayCalendarView.bottomAnchor, constant: DisplayCalendarResources.Constraint.eventFieldTopConstraint).isActive = true
        eventField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        eventField.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        view.addSubview(eventAddBtn)
        eventAddBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: DisplayCalendarResources.Constraint.eventAddBtnRightConstraint).isActive = true
        eventAddBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: DisplayCalendarResources.Constraint.eventAddBtnBottomConstraint).isActive = true
        eventAddBtn.widthAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.eventAddBtnWidthConstraint).isActive = true
        eventAddBtn.heightAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.eventAddBtnHeightConstraint).isActive = true
    }

    private func setupInsideDisplayCalendar() {
        displayCalendarView.addSubview(monthOfDayStack)
        monthOfDayStack.topAnchor.constraint(equalTo: displayCalendarView.topAnchor).isActive = true
        monthOfDayStack.leftAnchor.constraint(equalTo: displayCalendarView.leftAnchor).isActive = true
        monthOfDayStack.rightAnchor.constraint(equalTo: displayCalendarView.rightAnchor).isActive = true
        monthOfDayStack.heightAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.monthOfDayStackHeightConstraint).isActive = true
        displayCalendarView.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: monthOfDayStack.bottomAnchor, constant: DisplayCalendarResources.Constraint.calendarViewTopConstraint).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: displayCalendarView.bottomAnchor).isActive = true
        calendarView.widthAnchor.constraint(equalTo: displayCalendarView.widthAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.calendarViewHeightConstraint).isActive = true
    }
    
    private func setupViewModel() {
        eventAddBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.eventAddBtn.bounce(completion: {
                    guard let selectedDate = self?.selectedDateToSendRegistPage else { return }
                    guard let `self` = self?.navigationController else { return }
                    `self`.present(RegistCalendarViewController(selectedDate: selectedDate), animated: true)
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func setupCalendar() {
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    private func getCurrentDay() {
        calendarView.scrollToDate(Date(), animateScroll: false) {
            self.calendarView.selectDates([Date()])
        }
    }
    
    private func loadEventData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            let recievedData = self.getObjectFromServer()
            for (date, event) in recievedData {
                let stringDate = self.formatter.string(from: date)
                self.recievedFromServer[stringDate] = event
            }
            DispatchQueue.main.async {
                self.calendarView.reloadData()
            }
        }
    }
    
    private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else { return }
        self.formatter.dateFormat = "yyyy"
        self.dateOfYear.text = self.formatter.string(from: date)
        self.formatter.dateFormat = "MMMM"
        self.dateOfMonth.text = self.formatter.string(from: date)
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
            formatter.date(from: "2019 03 06")!: ["aaaaa"],
            formatter.date(from: "2019 03 05")!: ["bbbbb"],
            formatter.date(from: "2019 03 01")!: ["ccccc"],
            formatter.date(from: "2019 03 09")!: ["ddddd"],
            formatter.date(from: "2019 03 18")!: ["eeeee", "fffff"],
        ]
    }
}

extension DisplayCalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        guard let startDate = formatter.date(from: "2019 01 01"), let endDate = formatter.date(from: "2100 12 31") else {
            return ConfigurationParameters(startDate: Date(), endDate: Date())
        }
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: false)
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
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: String(describing: DisplayCalendarCell.self), for: indexPath) as? DisplayCalendarCell else { return }
        cell.configureInit(stateOfDateAtCalendar: cellState.text)
        if cellState.dateBelongsTo == .thisMonth {
            cell.stateOfDateAtCalendar.textColor = .black
        } else {
            cell.stateOfDateAtCalendar.textColor = .gray
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState, date: date)
        cell?.bounce()
        selectedDateToSendRegistPage = date
        let stringDate = formatter.string(from: cellState.date)
        for (date, events) in recievedFromServer {
            if date == stringDate {
                _ = events.map { event in
                    self.selectedDayEvent.append(CalendarEvent(event: event))
                }
                eventField.reloadData()
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState, date: date)
        selectedDayEvent = []
        eventField.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DisplayEventCell.self), for: indexPath) as? DisplayEventCell else { return UITableViewCell() }
        guard let event = selectedDayEvent[indexPath.row].event else { return cell }
        cell.configureInit(start: "10:00", end: "18:00", event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDayEvent.count
    }
}

extension DisplayCalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
