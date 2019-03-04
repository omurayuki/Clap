import Foundation
import UIKit
import RxCocoa
import RxSwift

class LoginViewCountroller: UIViewController {
    
    private struct Constants {
        struct Constraint {
            static let mailFieldTopConstraint: CGFloat = 80
            static let passFieldTopConstraint: CGFloat = 50
        }
        
        struct View {
            static let BtnCornerRadius: CGFloat = 15
        }
    }
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel?
    
    private lazy var noticeUserLoginTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_input_login_info()
        label.textColor = AppResources.ColorResources.baseColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mailField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var logintBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.log_in(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var reissuePass: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.to_forgot_pass(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.log_in()
        viewModel = LoginViewModel(emailField: mailField.rx.text.orEmpty.asObservable(), passField: passField.rx.text.orEmpty.asObservable())
        setupViewModel()
        setupUI()
    }
}

extension LoginViewCountroller {
    private func setupUI() {
        view.addSubview(noticeUserLoginTitle)
        noticeUserLoginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeUserLoginTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: noticeUserLoginTitle.bottomAnchor, constant: Constants.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: Constants.Constraint.passFieldTopConstraint).isActive = true
        passField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(logintBtn)
        logintBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logintBtn.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: view.bounds.size.width / 2).isActive = true
        logintBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(reissuePass)
        reissuePass.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reissuePass.topAnchor.constraint(equalTo: logintBtn.bottomAnchor, constant: view.bounds.size.width / 9.5).isActive = true
        reissuePass.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isLoginBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.logintBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)
        
        logintBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                print("遷移する")
            })
            .disposed(by: disposeBag)
    }
}

extension LoginViewCountroller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
