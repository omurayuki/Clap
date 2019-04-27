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
    
    weak var viewController: UIViewController?
    
    private(set) var noticeUserLoginTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_input_login_info()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        return label
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
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    private(set) var logintBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.log_in(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = LoginResources.View.BtnCornerRadius
        return button
    }()
    
    private(set) var reissuePass: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.to_forgot_pass(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = LoginResources.View.BtnCornerRadius
        return button
    }()
}

extension LoginUIImpl {
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.log_in()
        vc.view.addGestureRecognizer(viewTapGesture)
        [noticeUserLoginTitle, mailField, passField, logintBtn, reissuePass].forEach { vc.view.addSubview($0) }
        
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
    }
}
