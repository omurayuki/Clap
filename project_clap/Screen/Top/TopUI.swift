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
        topTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        topTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.height / 2.5).isActive = true
        vc.view.addSubview(loginBtn)
        loginBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: vc.view.bounds.size.height / 4).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(signupBtn)
        signupBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        signupBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: TopResources.Constraint.signupBtnTopConstraint).isActive = true
        signupBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
    }
}
