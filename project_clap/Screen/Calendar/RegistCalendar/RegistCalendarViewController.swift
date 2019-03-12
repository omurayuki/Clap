import Foundation
import UIKit
import RxSwift
import RxCocoa
import PopupDialog

class RegistCalendarViewController: UIViewController {
    
    private enum Date {
        enum BetweenDate {
            case startDate
            case endDate
        }
        
        enum BetweenTime {
            case startTime
            case endTime
        }
    }
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    private lazy var eventAddBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.check(), style: .plain, target: self, action: #selector(registEvent))
        return button
    }()
    
    private lazy var cancelBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.batsu(), style: .plain, target: self, action: #selector(cancelEvent))
        return button
    }()
    
    private lazy var registEvebtNavItem: UINavigationItem = {
        let nav = UINavigationItem()
        nav.leftBarButtonItem = cancelBtn
        nav.rightBarButtonItem = eventAddBtn
        return nav
    }()
    
    private lazy var registEventBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.barTintColor = .white
        bar.pushItem(registEvebtNavItem, animated: true)
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.title()
        field.textAlignment = .center
        field.font = RegistCalendarResources.Font.titleFieldFont
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        dp.addTarget(self, action: #selector(changeStartDate), for: .valueChanged)
        return dp
    }()
    
    private lazy var startDate: UITextField = {
        let field = UITextField()
        field.text = "2018年12月21日"
        field.textAlignment = .center
        field.tintColor = .clear
        field.inputView = startDatePicker
        field.font = RegistCalendarResources.Font.dateFont
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        dp.addTarget(self, action: #selector(changeEndDate), for: .valueChanged)
        return dp
    }()
    
    private lazy var endDate: UITextField = {
        let field = UITextField()
        field.text = "2018年12月21日"
        field.textAlignment = .center
        field.tintColor = .clear
        field.inputView = endDatePicker
        field.font = RegistCalendarResources.Font.dateFont
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startTimePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        dp.addTarget(self, action: #selector(changeStartTime), for: .valueChanged)
        return dp
    }()
    
    private lazy var startTime: UITextField = {
        let field = UITextField()
        field.text = "10:00"
        field.textAlignment = .center
        field.tintColor = .clear
        field.inputView = startTimePicker
        field.font = RegistCalendarResources.Font.timeFont
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endTimePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        dp.addTarget(self, action: #selector(changeEndTime), for: .valueChanged)
        return dp
    }()
    
    private lazy var endTime: UITextField = {
        let field = UITextField()
        field.text = "12:00"
        field.textAlignment = .center
        field.tintColor = .clear
        field.inputView = endTimePicker
        field.font = RegistCalendarResources.Font.timeFont
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var between: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.between()
        label.textAlignment = .center
        label.font = RegistCalendarResources.Font.betweenFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(startDate)
        stack.addArrangedSubview(startTime)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var endStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(endDate)
        stack.addArrangedSubview(endTime)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var totalTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(startStack)
        stack.addArrangedSubview(between)
        stack.addArrangedSubview(endStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var wrapTimeView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var longdayOrShortdayTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.long_day()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var switchLongdayOrShortday: UISwitch = {
        let `switch` = UISwitch()
        `switch`.translatesAutoresizingMaskIntoConstraints = false
        return `switch`
    }()
    
    private lazy var longdayOrShortdayStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(longdayOrShortdayTitle)
        stack.addArrangedSubview(switchLongdayOrShortday)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var detailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.detail()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailField: UITextView = {
        let field = UITextView()
        field.font = RegistCalendarResources.Font.detailFieldFont
        field.layer.cornerRadius = RegistCalendarResources.View.frtailFieldCornerRadius
        field.layer.borderWidth = RegistCalendarResources.View.frtailFieldCornerWidth
        field.layer.borderColor = UIColor.gray.cgColor
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(detailTitle)
        stack.addArrangedSubview(detailField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension RegistCalendarViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(registEventBar)
        registEventBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        registEventBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        registEventBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        view.addSubview(wrapTimeView)
        wrapTimeView.topAnchor.constraint(equalTo: registEventBar.bottomAnchor).isActive = true
        wrapTimeView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        wrapTimeView.addSubview(titleField)
        titleField.topAnchor.constraint(equalTo: wrapTimeView.topAnchor, constant: RegistCalendarResources.Constraint.titleFieldTopConstraint).isActive = true
        titleField.leftAnchor.constraint(equalTo: wrapTimeView.leftAnchor, constant: RegistCalendarResources.Constraint.titleFieldLeftCounstraint).isActive = true
        titleField.rightAnchor.constraint(equalTo: wrapTimeView.rightAnchor, constant: RegistCalendarResources.Constraint.titleFieldRightCounstraint).isActive = true
        wrapTimeView.addSubview(totalTimeStack)
        totalTimeStack.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackTopCounstraint).isActive = true
        totalTimeStack.leftAnchor.constraint(equalTo: wrapTimeView.leftAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackLeftCounstraint).isActive = true
        totalTimeStack.rightAnchor.constraint(equalTo: wrapTimeView.rightAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackRightCounstraint).isActive = true
        totalTimeStack.bottomAnchor.constraint(equalTo: wrapTimeView.bottomAnchor, constant: RegistCalendarResources.Constraint.totalTimeStackBottomCounstraint).isActive = true
        setupInsideTotalStack()
        view.addSubview(longdayOrShortdayStack)
        longdayOrShortdayStack.topAnchor.constraint(equalTo: wrapTimeView.bottomAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayStackTopCounstraint).isActive = true
        longdayOrShortdayStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayStackLeftCounstraint).isActive = true
        longdayOrShortdayStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayStackRightCounstraint).isActive = true
        setupInsideLongdayOrShortdayStack()
        view.addSubview(detailStack)
        detailStack.topAnchor.constraint(equalTo: longdayOrShortdayStack.bottomAnchor, constant: RegistCalendarResources.Constraint.detailStackTopConstraint).isActive = true
        detailStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: RegistCalendarResources.Constraint.detailStackLeftConstraint).isActive = true
        detailStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: RegistCalendarResources.Constraint.detailStackRightConstraint).isActive = true
        setupInsideDetailStack()
    }
    
    private func setupInsideTotalStack() {
        startDate.topAnchor.constraint(equalTo: startStack.topAnchor).isActive = true
        startDate.centerXAnchor.constraint(equalTo: startStack.centerXAnchor).isActive = true
        startTime.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: RegistCalendarResources.Constraint.startTimeTopConstraint).isActive = true
        startTime.centerXAnchor.constraint(equalTo: startStack.centerXAnchor).isActive = true
        endDate.topAnchor.constraint(equalTo: endStack.topAnchor).isActive = true
        endDate.centerXAnchor.constraint(equalTo: endStack.centerXAnchor).isActive = true
        endTime.topAnchor.constraint(equalTo: endDate.bottomAnchor, constant: RegistCalendarResources.Constraint.endTimeTopConstrint).isActive = true
        endTime.leftAnchor.constraint(equalTo: endStack.leftAnchor).isActive = true
    }
    
    private func setupInsideLongdayOrShortdayStack() {
        longdayOrShortdayTitle.topAnchor.constraint(equalTo: longdayOrShortdayStack.topAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayTitleTopCounstraint).isActive = true
        longdayOrShortdayTitle.leftAnchor.constraint(equalTo: longdayOrShortdayStack.leftAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayTitleLeftCounstraint).isActive = true
        longdayOrShortdayStack.bottomAnchor.constraint(equalTo: longdayOrShortdayStack.bottomAnchor, constant: RegistCalendarResources.Constraint.longdayOrShortdayTitleBottomCounstraint).isActive = true
        switchLongdayOrShortday.topAnchor.constraint(equalTo: longdayOrShortdayStack.topAnchor, constant: RegistCalendarResources.Constraint.switchLongdayOrShortdayTopCounstraint).isActive = true
        switchLongdayOrShortday.rightAnchor.constraint(equalTo: longdayOrShortdayStack.rightAnchor, constant: RegistCalendarResources.Constraint.switchLongdayOrShortdayRightCounstraint).isActive = true
        switchLongdayOrShortday.bottomAnchor.constraint(equalTo: longdayOrShortdayStack.bottomAnchor, constant: RegistCalendarResources.Constraint.switchLongdayOrShortdayBottomCounstraint).isActive = true
    }
    
    private func setupInsideDetailStack() {
        detailTitle.topAnchor.constraint(equalTo: detailStack.topAnchor, constant: RegistCalendarResources.Constraint.detailTitleTopConstraint).isActive = true
        detailTitle.leftAnchor.constraint(equalTo: detailStack.leftAnchor, constant: RegistCalendarResources.Constraint.detailTitleLeftConstraint).isActive = true
        detailField.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: RegistCalendarResources.Constraint.detailFieldTopConstraint).isActive = true
        detailField.leftAnchor.constraint(equalTo: detailStack.leftAnchor, constant: RegistCalendarResources.Constraint.detailFieldLeftConstraint).isActive = true
        detailField.rightAnchor.constraint(equalTo: detailStack.rightAnchor).isActive = true
        detailField.widthAnchor.constraint(equalToConstant: view.bounds.size.width - 50).isActive = true
        detailField.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 5).isActive = true
    }
    
    private func createCancelAlert() {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.lost_written_info())
        let logout = DefaultButton(title: R.string.locarizable.yes()) { self.dismiss(animated: true) }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) {}
        alert.addButtons([logout, cancel])
        self.present(alert, animated: true)
    }
    
    @objc
    private func registEvent() {
        //DBに保存+ローカルDBに保存
    }
    
    @objc
    private func cancelEvent() {
        createCancelAlert()
    }
    
    @objc
    private func changeStartDate() {
        formatter.dateFormat = "yyyy年MM月dd日"
        startDate.text = "\(formatter.string(from: startDatePicker.date))"
    }
    
    @objc
    private func changeEndDate() {
        formatter.dateFormat = "yyyy年MM月dd日"
        endDate.text = "\(formatter.string(from: endDatePicker.date))"
    }
    
    @objc
    private func changeStartTime() {
        formatter.dateFormat = "hh:mm"
        startTime.text = "\(formatter.string(from: startTimePicker.date))"
    }
    
    @objc
    private func changeEndTime() {
        formatter.dateFormat = "hh:mm"
        endTime.text = "\(formatter.string(from: endTimePicker.date))"
    }
}

extension RegistCalendarViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension RegistCalendarViewController: UITextViewDelegate {
    
}
