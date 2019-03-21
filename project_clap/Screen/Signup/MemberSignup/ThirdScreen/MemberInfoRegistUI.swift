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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var nameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.name()
        field.clearButtonMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var mailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var passField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var rePassField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.remain_password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
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
        field.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle(R.string.locarizable.regist(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = MemberInfoRegisterResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension MemberInfoRegistUIImpl {
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.regist_user()
        vc.view.addSubview(noticeUserRegistTitle)
        noticeUserRegistTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        noticeUserRegistTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(nameField)
        nameField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: noticeUserRegistTitle.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.nameFieldtopConstraint).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.passFieldTopConstraint).isActive = true
        passField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(rePassField)
        rePassField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        rePassField.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.rePassFieldTopConstraint).isActive = true
        rePassField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(memberPosition)
        memberPosition.topAnchor.constraint(equalTo: rePassField.bottomAnchor, constant: MemberInfoRegisterResources.Constraint.memberPositionTopConstraint).isActive = true
        memberPosition.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 3).isActive = true
        memberPosition.heightAnchor.constraint(equalToConstant: MemberInfoRegisterResources.Constraint.MemberPositionHeightConstraint).isActive = true
        memberPosition.leftAnchor.constraint(equalTo: rePassField.leftAnchor).isActive = true
        vc.view.addSubview(memberRegistBtn)
        memberRegistBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        memberRegistBtn.topAnchor.constraint(equalTo: memberPosition.bottomAnchor, constant: vc.view.bounds.size.width / 3).isActive = true
        memberRegistBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 2).isActive = true
        
        vc.view.addGestureRecognizer(viewTapGesture)
        positionToolBar.items = [doneBtn]
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
