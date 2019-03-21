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
        remindTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        remindTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        remindTitle.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width - RemindPassResources.Constraint.remindTitleWidthConstraint).isActive = true
        vc.view.addSubview(emailField)
        emailField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        emailField.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(submitBtn)
        submitBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        submitBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        submitBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        
        vc.view.addGestureRecognizer(viewTapGesture)
    }
}
