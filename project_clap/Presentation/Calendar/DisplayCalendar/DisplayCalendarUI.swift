import Foundation
import UIKit
import JTAppleCalendar

protocol DisplayCalendarUI: UI {
    var selectedDayEvent: [CalendarEvent] { get set }
    var selectedDateToSendRegistPage: Date { get set }
    var dateOfYear: UILabel { get }
    var dateOfMonth: UILabel { get }
    var sunday: UILabel { get }
    var monday: UILabel { get }
    var tuesday: UILabel { get }
    var wednesday: UILabel { get }
    var thursday: UILabel { get }
    var friday: UILabel { get }
    var saturday: UILabel { get }
    var displayCalendarView: CustomView { get }
    var monthOfDayStack: UIStackView { get }
    var calendarView: JTAppleCalendarView { get }
    var eventField: UITableView { get }
    var eventAddBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func setupInsideDisplayCalendar(vc: UIViewController)
    func coloringCalendar(calendar: JTAppleCalendarView, cell: JTAppleCell, cellState: CellState, indexPath: IndexPath)
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

final class DisplayCalendarUIImpl: DisplayCalendarUI {
    
    var selectedDayEvent: [CalendarEvent] = []
    var selectedDateToSendRegistPage: Date = Date()
    
    var dateOfYear: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.dateOfYearFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateOfMonth: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.dateOfMonth
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewController: UIViewController?
    
    var sunday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.sunday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var monday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.monday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tuesday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.tuesday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var wednesday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.wednesday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var thursday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.thursday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var friday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.friday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var saturday: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.saturday()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var displayCalendarView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var monthOfDayStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var calendarView: JTAppleCalendarView = {
        let calendar = JTAppleCalendarView()
        calendar.scrollingMode = .stopAtEachCalendarFrame
        calendar.showsHorizontalScrollIndicator = false
        calendar.showsVerticalScrollIndicator = false
        calendar.backgroundColor = .clear
        calendar.tintColor = .black
        calendar.scrollDirection = .horizontal
        calendar.register(DisplayCalendarCell.self, forCellWithReuseIdentifier: String(describing: DisplayCalendarCell.self))
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    var eventField: UITableView  = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = AppResources.ColorResources.appCommonClearColor
        table.rowHeight = DisplayCalendarResources.View.tableViewHeight
        table.register(DisplayEventCell.self, forCellReuseIdentifier: String(describing: DisplayEventCell.self))
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var eventAddBtn: UIButton  = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension DisplayCalendarUIImpl {
    func setup(vc: UIViewController) {
        monthOfDayStack.addArrangedSubview(sunday)
        monthOfDayStack.addArrangedSubview(monday)
        monthOfDayStack.addArrangedSubview(tuesday)
        monthOfDayStack.addArrangedSubview(wednesday)
        monthOfDayStack.addArrangedSubview(thursday)
        monthOfDayStack.addArrangedSubview(friday)
        monthOfDayStack.addArrangedSubview(saturday)
        vc.view.backgroundColor = .white
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        vc.navigationController?.navigationBar.barTintColor = .white
        vc.navigationItem.title = R.string.locarizable.calendar_title()
        vc.view.addSubview(dateOfYear)
        dateOfYear.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateOfYear.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: DisplayCalendarResources.Constraint.dateOfYearLeftConstraint).isActive = true
        vc.view.addSubview(dateOfMonth)
        dateOfMonth.topAnchor.constraint(equalTo: dateOfYear.bottomAnchor, constant: DisplayCalendarResources.Constraint.dateOfMonthTopConstraint).isActive = true
        dateOfMonth.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: DisplayCalendarResources.Constraint.dateOfMonthLeftConstraint).isActive = true
        vc.view.addSubview(displayCalendarView)
        displayCalendarView.topAnchor.constraint(equalTo: dateOfMonth.bottomAnchor, constant: DisplayCalendarResources.Constraint.displayCalendarViewTopConstraint).isActive = true
        displayCalendarView.heightAnchor.constraint(equalToConstant: vc.view.bounds.size.height / 2).isActive = true
        displayCalendarView.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        vc.view.addSubview(eventField)
        eventField.topAnchor.constraint(equalTo: displayCalendarView.bottomAnchor, constant: DisplayCalendarResources.Constraint.eventFieldTopConstraint).isActive = true
        eventField.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        eventField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        vc.view.addSubview(eventAddBtn)
        eventAddBtn.bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: DisplayCalendarResources.Constraint.eventAddBtnRightConstraint).isActive = true
        eventAddBtn.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: DisplayCalendarResources.Constraint.eventAddBtnBottomConstraint).isActive = true
        eventAddBtn.widthAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.eventAddBtnWidthConstraint).isActive = true
        eventAddBtn.heightAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.eventAddBtnHeightConstraint).isActive = true
    }
    
    func setupInsideDisplayCalendar(vc: UIViewController) {
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
    
    func coloringCalendar(calendar: JTAppleCalendarView, cell: JTAppleCell, cellState: CellState, indexPath: IndexPath) {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: String(describing: DisplayCalendarCell.self), for: indexPath) as? DisplayCalendarCell else { return }
        cell.configureInit(stateOfDateAtCalendar: cellState.text)
        if cellState.dateBelongsTo == .thisMonth {
            cell.stateOfDateAtCalendar.textColor = .black
        } else {
            cell.stateOfDateAtCalendar.textColor = .gray
        }
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DisplayEventCell.self), for: indexPath) as? DisplayEventCell else { return UITableViewCell() }
        guard let event = selectedDayEvent[indexPath.row].event else { return cell }
        cell.configureInit(start: "10:00", end: "18:00", event: event)
        return cell
    }
}
