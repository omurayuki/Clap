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
        vc.view.addSubview(mailField)
        vc.view.addSubview(passField)
        vc.view.addSubview(logintBtn)
        vc.view.addSubview(reissuePass)
        noticeUserLoginTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        mailField.anchor()
            .centerXToSuperview()
            .top(to: noticeUserLoginTitle.bottomAnchor, constant: LoginResources.Constraint.mailFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        passField.anchor()
            .centerXToSuperview()
            .top(to: mailField.bottomAnchor, constant: LoginResources.Constraint.passFieldTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        logintBtn.anchor()
            .centerXToSuperview()
            .top(to: passField.bottomAnchor, constant: vc.view.bounds.size.width / 2)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        reissuePass.anchor()
            .centerXToSuperview()
            .top(to: logintBtn.bottomAnchor, constant: vc.view.bounds.size.width / 9.5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        vc.view.addGestureRecognizer(viewTapGesture)
    }
}