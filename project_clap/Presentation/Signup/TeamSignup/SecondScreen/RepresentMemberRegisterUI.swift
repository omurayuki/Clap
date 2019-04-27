import Foundation
import UIKit

protocol RepresentMemberRegisterUI: UI {
    var noticeUserRegistTitle: UILabel { get }
    var userPhotoRegistBtn: UIButton { get }
    var nameField: CustomTextField { get }
    var mailField: CustomTextField { get }
    var passField: CustomTextField { get }
    var rePassField: CustomTextField { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var representMemberPosition: CustomTextField { get }
    var representMemberYear: CustomTextField { get }
    var stack: UIStackView { get }
    var teamRegistBtn: UIButton { get }
    var positionToolBar: UIToolbar { get }
    var positionDoneBtn: UIBarButtonItem { get }
    var yearToolBar: UIToolbar { get }
    var yearDoneBtn: UIBarButtonItem { get }
    
    func setup(storeName: String)
    func setupInsideStack(vc: UIViewController)
    func getPickerView(type: RepresentMemberRegisterPickerType, vc: UIViewController) -> UIPickerView
    func setupToolBar(_ textField: UITextField, type: RepresentMemberRegisterPickerType, toolBar: UIToolbar, content: Array<String>, vc: UIViewController)
}

final class RepresentMemberRegisterUIImpl: RepresentMemberRegisterUI {
    
    weak var viewController: UIViewController?
    
    private(set) var noticeUserRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_user_regist()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        return label
    }()
    
    private(set) var userPhotoRegistBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = RepresentMemberRegisterResources.View.photoCornerRadius
        return button
    }()
    
    private(set) var nameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.name()
        field.clearButtonMode = .always
        return field
    }()
    
    private(set) var mailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        return field
    }()
    
    private(set) var passField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        return field
    }()
    
    private(set) var rePassField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.remain_password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        return field
    }()
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    private(set) var representMemberPosition: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        return field
    }()
    
    private(set) var representMemberYear: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        return field
    }()
    
    private(set) var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private(set) var teamRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.regist(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = RepresentMemberRegisterResources.View.btnCornerRadius
        return button
    }()
    
    private(set) var positionToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: RepresentMemberRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private(set) var positionDoneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
    
    private(set) var yearToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: RepresentMemberRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private(set) var yearDoneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
}

extension RepresentMemberRegisterUIImpl {
    func setup(storeName: String) {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.navigationItem.title = storeName
        vc.view.addGestureRecognizer(viewTapGesture)
        positionToolBar.items = [positionDoneBtn]
        yearToolBar.items = [yearDoneBtn]
        [representMemberPosition, representMemberYear].forEach { stack.addArrangedSubview($0) }
        [noticeUserRegistTitle, userPhotoRegistBtn, nameField, mailField,
        passField, rePassField, stack, teamRegistBtn].forEach { vc.view.addSubview($0) }
        
        noticeUserRegistTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        userPhotoRegistBtn.anchor()
            .centerXToSuperview()
            .top(to: noticeUserRegistTitle.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.userPhotoRegistBtnTopConstraint)
            .width(constant: RepresentMemberRegisterResources.Constraint.btnHeightConstraint)
            .height(constant: RepresentMemberRegisterResources.Constraint.btnWidthConstraint)
            .activate()
        
        nameField.anchor()
            .centerXToSuperview()
            .top(to: userPhotoRegistBtn.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.nameFieldtopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        mailField.anchor()
            .centerXToSuperview()
            .top(to: nameField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.mailFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        passField.anchor()
            .centerXToSuperview()
            .top(to: mailField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.passFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        rePassField.anchor()
            .centerXToSuperview()
            .top(to: passField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.rePassFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        stack.anchor()
            .centerXToSuperview()
            .top(to: rePassField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.stackTopConstraint)
            .activate()
        
        teamRegistBtn.anchor()
            .centerXToSuperview()
            .top(to: stack.bottomAnchor, constant: vc.view.bounds.size.width / 5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
    }
    
    func setupInsideStack(vc: UIViewController) {
        
        representMemberPosition.anchor()
            .width(constant: vc.view.bounds.size.width / 6)
            .height(constant: RepresentMemberRegisterResources.Constraint.representMemberPositionHeightConstraint)
            .activate()

        representMemberYear.anchor()
            .width(constant: vc.view.bounds.size.width / 6)
            .height(constant: RepresentMemberRegisterResources.Constraint.representMemberYearHeightConstraint)
            .activate()

        representMemberYear.leftAnchor.constraint(equalTo: representMemberPosition.rightAnchor, constant: vc.view.bounds.size.width / 3).isActive = true
    }
    
    func getPickerView(type: RepresentMemberRegisterPickerType, vc: UIViewController) -> UIPickerView {
        var pickerView = UIPickerView()
        switch type {
        case .position: pickerView = PositionPickerView()
        case .year: pickerView = YearPickerView()
        }
        pickerView.dataSource = vc as? UIPickerViewDataSource
        pickerView.delegate = vc as? UIPickerViewDelegate
        pickerView.backgroundColor = .white
        return pickerView
    }
    
    func setupToolBar(_ textField: UITextField, type: RepresentMemberRegisterPickerType, toolBar: UIToolbar, content: Array<String>, vc: UIViewController) {
        textField.inputView = getPickerView(type: type, vc: vc)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
}

class PositionPickerView: UIPickerView {}
class YearPickerView: UIPickerView {}
