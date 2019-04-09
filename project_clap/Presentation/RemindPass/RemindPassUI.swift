import Foundation
import UIKit

protocol RemindPassUI: UI {
    var remindTitle: UILabel { get }
    var emailField: CustomTextField { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var submitBtn: UIButton { get }
    
    func setup(vc: UIViewController)
}

final class RemindPassUIImple: RemindPassUI {
    
    weak var viewController: UIViewController?
    
    private(set) var remindTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_remind_label()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.numberOfLines = RemindPassResources.View.titleNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var emailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    private(set) var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.submit(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TeamInfoRegisterResources.View.nextBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension RemindPassUIImple {
    
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.password_settings()
        vc.view.addSubview(remindTitle)
        vc.view.addSubview(emailField)
        vc.view.addSubview(submitBtn)
        vc.view.addGestureRecognizer(viewTapGesture)
        remindTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .width(constant: vc.view.bounds.size.width - RemindPassResources.Constraint.remindTitleWidthConstraint)
            .activate()
        
        emailField.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        submitBtn.anchor()
            .centerXToSuperview()
            .top(to: emailField.bottomAnchor, constant: vc.view.bounds.size.width / 2.5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
}
