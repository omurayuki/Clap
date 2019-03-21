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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var userPhotoRegistBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    private(set) var representMemberPosition: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var representMemberYear: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var teamRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.regist(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = RepresentMemberRegisterResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
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
        stack.addArrangedSubview(representMemberPosition)
        stack.addArrangedSubview(representMemberYear)
        vc.view.addSubview(noticeUserRegistTitle)
        noticeUserRegistTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        noticeUserRegistTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(userPhotoRegistBtn)
        userPhotoRegistBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        userPhotoRegistBtn.topAnchor.constraint(equalTo: noticeUserRegistTitle.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.userPhotoRegistBtnTopConstraint).isActive = true
        userPhotoRegistBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 7).isActive = true
        userPhotoRegistBtn.heightAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 7).isActive = true
        vc.view.addSubview(nameField)
        nameField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: userPhotoRegistBtn.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.nameFieldtopConstraint).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.passFieldTopConstraint).isActive = true
        passField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(rePassField)
        rePassField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        rePassField.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.rePassFieldTopConstraint).isActive = true
        rePassField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: rePassField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.stackTopConstraint).isActive = true
        vc.view.addSubview(teamRegistBtn)
        teamRegistBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        teamRegistBtn.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: vc.view.bounds.size.width / 3).isActive = true
        teamRegistBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        
        vc.view.addGestureRecognizer(viewTapGesture)
        positionToolBar.items = [positionDoneBtn]
        yearToolBar.items = [yearDoneBtn]
    }
    
    func setupInsideStack(vc: UIViewController) {
        representMemberPosition.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 6).isActive = true
        representMemberPosition.heightAnchor.constraint(equalToConstant: RepresentMemberRegisterResources.Constraint.representMemberPositionHeightConstraint).isActive = true
        representMemberYear.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 6).isActive = true
        representMemberYear.heightAnchor.constraint(equalToConstant: RepresentMemberRegisterResources.Constraint.representMemberYearHeightConstraint).isActive = true
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
