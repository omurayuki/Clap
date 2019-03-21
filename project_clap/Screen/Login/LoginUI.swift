import Foundation
import UIKit

protocol LoginUI: UI {
    var noticeUserLoginTitle: UILabel { get }
    var mailField: CustomTextField { get }
    var passField: CustomTextField { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var logintBtn: UIButton { get }
    var reissuePass: UIButton { get }
    
    func setup(vc: UIViewController)
}

final class LoginUIImpl: LoginUI {
    
    var viewController: UIViewController?
    
    var noticeUserLoginTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_input_login_info()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var passField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    var logintBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.log_in(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = LoginResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var reissuePass: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.to_forgot_pass(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = LoginResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension LoginUIImpl {
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.log_in()
        vc.view.addSubview(noticeUserLoginTitle)
        noticeUserLoginTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        noticeUserLoginTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: noticeUserLoginTitle.bottomAnchor, constant: LoginResources.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: LoginResources.Constraint.passFieldTopConstraint).isActive = true
        passField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(logintBtn)
        logintBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        logintBtn.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: vc.view.bounds.size.width / 2).isActive = true
        logintBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(reissuePass)
        reissuePass.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        reissuePass.topAnchor.constraint(equalTo: logintBtn.bottomAnchor, constant: vc.view.bounds.size.width / 9.5).isActive = true
        reissuePass.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        
        vc.view.addGestureRecognizer(viewTapGesture)
    }
}
