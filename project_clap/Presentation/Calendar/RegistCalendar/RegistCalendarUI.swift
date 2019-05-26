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
    var longdayOrShortdayTitle: UILabel { get }
    var switchLongdayOrShortday: UISwitch { get }
    var detailTitle: UILabel { get }
    var detailField: UITextView { get }
    var submitBtn: UIButton { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    
    func setup(vc: UIViewController)
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
        return bar
    }()
    
    var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.title()
        field.textAlignment = .center
        field.font = RegistCalendarResources.Font.titleFieldFont
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
        return field
    }()
    
    var between: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.between()
        label.textAlignment = .center
        label.font = RegistCalendarResources.Font.betweenFont
        return label
    }()
    
    var longdayOrShortdayTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.long_day()
        label.textColor = .gray
        return label
    }()
    
    var switchLongdayOrShortday: UISwitch = {
        let `switch` = UISwitch()
        return `switch`
    }()
    
    var detailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.detail()
        label.textColor = .gray
        return label
    }()
    
    var detailField: UITextView = {
        let field = UITextView()
        field.font = RegistCalendarResources.Font.detailFieldFont
        field.layer.cornerRadius = RegistCalendarResources.View.frtailFieldCornerRadius
        field.layer.borderWidth = RegistCalendarResources.View.frtailFieldCornerWidth
        field.layer.borderColor = UIColor.gray.cgColor
        return field
    }()
    
    var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("送信", for: .normal)
        button.backgroundColor = AppResources.ColorResources.shallowBlueColor
        button.layer.cornerRadius = 15
        button.frame.size.width = 200
        return button
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
        vc.view.addGestureRecognizer(viewTapGesture)
        vc.view.backgroundColor = .white
        
        let stack = setupStack()
        vc.view.addSubview(stack)
        stack.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor, constant: 10)
            .left(to: vc.view.leftAnchor, constant: 10)
            .right(to: vc.view.rightAnchor, constant: -10)
            .bottom(to: vc.view.bottomAnchor, constant: -10)
            .activate()
    }
    
    private func setupStack() -> UIStackView {
        let stack = VerticalStackView(arrangeSubViews: [
            titleField,
            CustomStackView(arrangedSubviews: [
                VerticalStackView(arrangeSubViews: [
                    startDate,
                    startTime
                ], spacing: 3),
                between,
                VerticalStackView(arrangeSubViews: [
                    endDate,
                    endTime
                ], spacing: 3)
            ]),
            UIStackView(arrangedSubviews: [
                longdayOrShortdayTitle,
                UIView(),
                switchLongdayOrShortday
            ]),
            VerticalStackView(arrangeSubViews: [
                detailTitle,
                detailField,
                submitBtn
            ], spacing: 5)
        ], spacing: 10)
        
        return stack
    }
    
    func createCancelAlert(vc: UIViewController) {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.lost_written_info())
        let logout = DefaultButton(title: R.string.locarizable.yes()) { vc.dismiss(animated: true) }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) {}
        alert.addButtons([logout, cancel])
        vc.present(alert, animated: true)
    }
}
