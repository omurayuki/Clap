import Foundation
import UIKit
import PopupDialog

protocol RegistCalendarUI: UI {
    var eventAddBtn: UIBarButtonItem { get }
    var cancelBtn: UIBarButtonItem { get }
    var registEvebtNavItem: UINavigationItem { get }
    var registEventBar: UINavigationBar { get }
    var titleField: UITextField { get }
    var startDatePicker: UIDatePicker { get }
    var startDate: UITextField { get }
    var endDatePicker: UIDatePicker { get }
    var endDate: UITextField { get }
    var startTimePicker: UIDatePicker { get }
    var startTime: UITextField { get }
    var endTimePicker: UIDatePicker { get }
    var endTime: UITextField { get }
    var between: UILabel { get }
    var startStack: UIStackView { get }
    var endStack: UIStackView { get }
    var totalTimeStack: UIStackView { get }
    var wrapTimeView: CustomView { get }
    var longdayOrShortdayTitle: UILabel { get }
    var switchLongdayOrShortday: UISwitch { get }
    var longdayOrShortdayStack: UIStackView { get }
    var detailTitle: UILabel { get }
    var detailField: UITextView { get }
    var detailStack: UIStackView { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    
    func setup(vc: UIViewController)
    func setupInsideTotalStack(vc: UIViewController)
    func setupInsideLongdayOrShortdayStack(vc: UIViewController)
    func setupInsideDetailStack(vc: UIViewController)
    func createCancelAlert(vc: UIViewController)
}

final class RegistCalendarUIImple: RegistCalendarUI {
    
    var viewController: UIViewController?
    
    var eventAddBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.check(), style: .plain, target: nil, action: nil)
        return button
    }()
    
    var cancelBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.batsu(), style: .plain, target: nil, action: nil)
        return button
    }()
    
    var registEvebtNavItem: UINavigationItem = {
        let nav = UINavigationItem()
        return nav
    }()
    
    var registEventBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.barTintColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.title()
        field.textAlignment = .center
        field.font = RegistCalendarResources.Font.titleFieldFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        return dp
    }()
    
    var startDate: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.tintColor = .clear
        field.font = RegistCalendarResources.Font.defaultDateFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var endDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        return dp
    }()
    
    var endDate: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.tintColor = .clear
        field.font = RegistCalendarResources.Font.defaultDateFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var startTimePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        return dp
    }()
    
    var startTime: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.tintColor = .clear
        field.font = RegistCalendarResources.Font.timeFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var endTimePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        return dp
    }()
    
    var endTime: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.tintColor = .clear
        field.font = RegistCalendarResources.Font.timeFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var between: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.between()
        label.textAlignment = .center
        label.font = RegistCalendarResources.Font.betweenFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var startStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var endStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var totalTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var wrapTimeView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var longdayOrShortdayTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.long_day()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var switchLongdayOrShortday: UISwitch = {
        let `switch` = UISwitch()
        `switch`.translatesAutoresizingMaskIntoConstraints = false
        return `switch`
    }()
    
    var longdayOrShortdayStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var detailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.detail()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailField: UITextView = {
        let field = UITextView()
        field.font = RegistCalendarResources.Font.detailFieldFont
        field.layer.cornerRadius = RegistCalendarResources.View.frtailFieldCornerRadius
        field.layer.borderWidth = RegistCalendarResources.View.frtailFieldCornerWidth
        field.layer.borderColor = UIColor.gray.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
}

extension RegistCalendarUIImple {
    func setup(vc: UIViewController) {
        registEvebtNavItem.leftBarButtonItem = cancelBtn
        registEvebtNavItem.rightBarButtonItem = eventAddBtn
        registEventBar.pushItem(registEvebtNavItem, animated: true)
        startDate.inputView = startDatePicker
        endDate.inputView = endDatePicker
        startTime.inputView = startTimePicker
        endTime.inputView = endTimePicker
        [startDate, startTime].forEach { startStack.addArrangedSubview($0) }
        [endDate, endTime].forEach { endStack.addArrangedSubview($0) }
        [startStack, between, endStack].forEach { totalTimeStack.addArrangedSubview($0) }
        [longdayOrShortdayTitle, switchLongdayOrShortday].forEach { longdayOrShortdayStack.addArrangedSubview($0) }
        [detailTitle, detailField].forEach { detailStack.addArrangedSubview($0) }
        vc.view.addGestureRecognizer(viewTapGesture)
        vc.view.backgroundColor = .white
        vc.view.addSubview(registEventBar)
        registEventBar.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor).isActive = true
        registEventBar.leftAnchor.constraint(equalTo: vc.view.leftAnchor).isActive = true
        registEventBar.rightAnchor.constraint(equalTo: vc.view.rightAnchor).isActive = true
        vc.view.addSubview(wrapTimeView)
        wrapTimeView.topAnchor.constraint(equalTo: registEventBar.bottomAnchor).isActive = true
        wrapTimeView.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        wrapTimeView.addSubview(titleField)
        titleField.topAnchor.constraint(equalTo: wrapTimeView.topAnchor, constant: RegistCalendarResources.Constraint.titleFieldTopConstraint).isActive = true
        titleField.leftAnchor.constraint(equalTo: wrapTimeView.leftAnchor, constant: RegistCalendarResources.Constraint.titleFieldLeftCounstraint).isActive = true
        titleField.rightAnchor.constraint(equalTo: wrapTimeView.rightAnchor, constant: RegistCalendarResources.Constraint.titleFieldRightCounstraint).isActive = true
        wrapTimeView.addSubview(totalTimeStack)
        totalTimeStack.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackTopCounstraint).isActive = true
        totalTimeStack.leftAnchor.constraint(equalTo: wrapTimeView.leftAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackLeftCounstraint).isActive = true
        totalTimeStack.rightAnchor.constraint(equalTo: wrapTimeView.rightAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackRightCounstraint).isActive = true
        totalTimeStack.bottomAnchor.constraint(equalTo: wrapTimeView.bottomAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackBottomCounstraint).isActive = true
        setupInsideTotalStack(vc: vc)
        vc.view.addSubview(longdayOrShortdayStack)
        longdayOrShortdayStack.topAnchor.constraint(equalTo: wrapTimeView.bottomAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayStackTopCounstraint).isActive = true
        longdayOrShortdayStack.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayStackLeftCounstraint).isActive = true
        longdayOrShortdayStack.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayStackRightCounstraint).isActive = true
        setupInsideLongdayOrShortdayStack(vc: vc)
        vc.view.addSubview(detailStack)
        detailStack.topAnchor.constraint(equalTo: longdayOrShortdayStack.bottomAnchor, constant: RegistCalendarResources.Constraint.detailStackTopConstraint).isActive = true
        detailStack.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: RegistCalendarResources.Constraint.detailStackLeftConstraint).isActive = true
        detailStack.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: RegistCalendarResources.Constraint.detailStackRightConstraint).isActive = true
        setupInsideDetailStack(vc: vc)
    }
    
    func setupInsideTotalStack(vc: UIViewController) {
        startDate.topAnchor.constraint(equalTo: startStack.topAnchor).isActive = true
        startDate.centerXAnchor.constraint(equalTo: startStack.centerXAnchor).isActive = true
        startDate.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startTime.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: RegistCalendarResources.Constraint.startTimeTopConstraint).isActive = true
        startTime.centerXAnchor.constraint(equalTo: startStack.centerXAnchor).isActive = true
        endDate.topAnchor.constraint(equalTo: endStack.topAnchor).isActive = true
        endDate.centerXAnchor.constraint(equalTo: endStack.centerXAnchor).isActive = true
        endDate.widthAnchor.constraint(equalToConstant: 150).isActive = true
        endTime.topAnchor.constraint(equalTo: endDate.bottomAnchor, constant: RegistCalendarResources.Constraint.endTimeTopConstrint).isActive = true
        endTime.leftAnchor.constraint(equalTo: endStack.leftAnchor).isActive = true
    }
    
    func setupInsideLongdayOrShortdayStack(vc: UIViewController) {
        longdayOrShortdayTitle.topAnchor.constraint(equalTo: longdayOrShortdayStack.topAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayTitleTopCounstraint).isActive = true
        longdayOrShortdayTitle.leftAnchor.constraint(equalTo: longdayOrShortdayStack.leftAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayTitleLeftCounstraint).isActive = true
        longdayOrShortdayStack.bottomAnchor.constraint(equalTo: longdayOrShortdayStack.bottomAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayTitleBottomCounstraint).isActive = true
        switchLongdayOrShortday.topAnchor.constraint(equalTo: longdayOrShortdayStack.topAnchor, constant: RegistCalendarResources.Constraint.switchLongdayOrShortdayTopCounstraint).isActive = true
        switchLongdayOrShortday.rightAnchor.constraint(equalTo: longdayOrShortdayStack.rightAnchor, constant: RegistCalendarResources.Constraint.switchLongdayOrShortdayRightCounstraint).isActive = true
        switchLongdayOrShortday.bottomAnchor.constraint(equalTo: longdayOrShortdayStack.bottomAnchor, constant: RegistCalendarResources.Constraint.switchLongdayOrShortdayBottomCounstraint).isActive = true
    }
    
    func setupInsideDetailStack(vc: UIViewController) {
        detailTitle.topAnchor.constraint(equalTo: detailStack.topAnchor, constant: RegistCalendarResources.Constraint.detailTitleTopConstraint).isActive = true
        detailTitle.leftAnchor.constraint(equalTo: detailStack.leftAnchor, constant: RegistCalendarResources.Constraint.detailTitleLeftConstraint).isActive = true
        detailField.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: RegistCalendarResources.Constraint.detailFieldTopConstraint).isActive = true
        detailField.leftAnchor.constraint(equalTo: detailStack.leftAnchor, constant: RegistCalendarResources.Constraint.detailFieldLeftConstraint).isActive = true
        detailField.rightAnchor.constraint(equalTo: detailStack.rightAnchor).isActive = true
        detailField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width - 50).isActive = true
        detailField.heightAnchor.constraint(equalToConstant: vc.view.bounds.size.height / 5).isActive = true
    }
    
    func createCancelAlert(vc: UIViewController) {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.lost_written_info())
        let logout = DefaultButton(title: R.string.locarizable.yes()) { vc.dismiss(animated: true) }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) {}
        alert.addButtons([logout, cancel])
        vc.present(alert, animated: true)
    }
}
