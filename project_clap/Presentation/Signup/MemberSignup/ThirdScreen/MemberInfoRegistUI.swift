import Foundation
import UIKit

protocol MemberInfoRegistUI: UI {
    var noticeUserRegistTitle: UILabel { get }
    var nameField: CustomTextField { get }
    var mailField: CustomTextField { get }
    var passField: CustomTextField { get }
    var rePassField: CustomTextField { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var memberPosition: CustomTextField { get }
    var positionToolBar: UIToolbar { get }
    var doneBtn: UIBarButtonItem { get }
    var memberRegistBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func getPickerView(vc: UIViewController) -> UIPickerView
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController)
}

final class MemberInfoRegistUIImpl: MemberInfoRegistUI {
    
    weak var viewController: UIViewController?
    
    private(set) var noticeUserRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_user_regist()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        return label
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
    
    private(set) var memberPosition: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        return field
    }()
    
    private(set) var positionToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: MemberInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = UIColor.white
        return accessoryToolbar
    }()
    
    private(set) var doneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
    
    private(set) var memberRegistBtn: UIButton = {
        let button = UIButton()
        button.alpha = 0.2
        button.isUserInteractionEnabled = false
        button.setTitle(R.string.locarizable.regist(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = MemberInfoRegisterResources.View.BtnCornerRadius
        return button
    }()
}

extension MemberInfoRegistUIImpl {
    func setup(vc: UIViewController) {
        positionToolBar.items = [doneBtn]
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.regist_user()
        vc.view.addGestureRecognizer(viewTapGesture)
        vc.view.addSubview(memberRegistBtn)
        [noticeUserRegistTitle, nameField, mailField, passField, rePassField, memberPosition, memberRegistBtn].forEach { vc.view.addSubview($0) }
        
        noticeUserRegistTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        nameField.anchor()
            .centerXToSuperview()
            .top(to: noticeUserRegistTitle.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.nameFieldtopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        mailField.anchor()
            .centerXToSuperview()
            .top(to: nameField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.passFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        passField.anchor()
            .centerXToSuperview()
            .top(to: mailField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.passFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        rePassField.anchor()
            .centerXToSuperview()
            .top(to: passField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.rePassFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        memberPosition.anchor()
            .top(to: rePassField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.memberPositionTopConstraint)
            .height(constant: MemberInfoRegisterResources.Constraint.MemberPositionHeightConstraint)
            .left(to: rePassField.leftAnchor)
            .activate()
        
        memberRegistBtn.anchor()
            .centerXToSuperview()
            .top(to: memberPosition.bottomAnchor, constant: vc.view.bounds.size.width / 3)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
    
    func getPickerView(vc: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = vc as? UIPickerViewDataSource
        pickerView.delegate = vc as? UIPickerViewDelegate
        pickerView.backgroundColor = .white
        return pickerView
    }
    
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController) {
        textField.inputView = getPickerView(vc: vc)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
}
