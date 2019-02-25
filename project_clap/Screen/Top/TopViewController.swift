import Foundation
import UIKit
 
class TopViewController: UIViewController {
    
    private struct Constants {
        struct Constraint {
            static let signupBtnTopConstraint: CGFloat = 20
        }
        
        struct View {
            static let BtnCornerRadius: CGFloat = 15
        }
    }
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.clap()
        label.textColor = AppResources.ColorResources.baseColor
        label.font = AppResources.FontResources.topLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.log_in(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.BtnCornerRadius
        button.addTarget(self, action: #selector(showLogin(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signupBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.sign_up(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.BtnCornerRadius
        button.addTarget(self, action: #selector(showSignup(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupUI()
    }
}

extension TopViewController {
    private func setupUI() {
        view.addSubview(topTitle)
        topTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addSubview(loginBtn)
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: view.bounds.size.height / 4).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 2).isActive = true
        view.addSubview(signupBtn)
        signupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: Constants.Constraint.signupBtnTopConstraint).isActive = true
        signupBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 2).isActive = true
    }
    
    private func setupNaviBar() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }
    
    @objc
    func showLogin(sender: UIButton) {
        navigationController?.pushViewController(LoginViewCountroller(), animated: true)
    }
    
    @objc
    func showSignup(sender: UIButton) {
        navigationController?.pushViewController(SelectViewController(), animated: true)
    }
}
