import Foundation
import UIKit
 
class TopViewController: UIViewController {
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Clap"
        label.textColor = UIColor(hex: "eab60e")
        label.font = .systemFont(ofSize: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("ログイン", for: .normal)
        button.backgroundColor = UIColor(hex: "eab60e")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(showLogin(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signupBtn: UIButton = {
        let button = UIButton()
        button.setTitle("新規登録", for: .normal)
        button.backgroundColor = UIColor(hex: "eab60e")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(showSignup(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        signupBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20).isActive = true
        signupBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 2).isActive = true
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
