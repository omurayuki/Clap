import Foundation
import UIKit

protocol TopUI: UI {
    var topTitle: UILabel { get }
    var loginBtn: UIButton { get }
    var signupBtn: UIButton { get }
    
    func setup()
}

final class TopUIImpl: TopUI {
    
    weak var viewController: UIViewController?
    
    private(set) var topTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.clap()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.font = AppResources.FontResources.topLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.log_in(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TopResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var signupBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.sign_up(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TopResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension TopUIImpl {
    func setup() {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        vc.navigationController?.navigationBar.barTintColor = .white
        vc.view.addSubview(topTitle)
        vc.view.addSubview(loginBtn)
        vc.view.addSubview(signupBtn)
        topTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.height / 2.5)
            .activate()
        
        loginBtn.anchor()
            .centerXToSuperview()
            .top(to: topTitle.bottomAnchor, constant: vc.view.bounds.size.height / 4)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()

        signupBtn.anchor()
            .centerXToSuperview()
            .top(to: loginBtn.bottomAnchor, constant: TopResources.Constraint.signupBtnTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
}
