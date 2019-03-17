import Foundation
import UIKit
import RxCocoa
import RxSwift

class LoginViewCountroller: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel?
    
    private lazy var noticeUserLoginTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_input_login_info()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passField: CustomTextField = {
        let field = CustomTextField()
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
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = LoginResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var reissuePass: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.to_forgot_pass(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = LoginResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(emailField: mailField.rx.text.orEmpty.asDriver(), passField: passField.rx.text.orEmpty.asDriver(), loginTapped: logintBtn.rx.tap.asDriver())
        setupViewModel()
        setupUI()
    }
}

extension LoginViewCountroller {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.log_in()
        view.addSubview(noticeUserLoginTitle)
        noticeUserLoginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeUserLoginTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: noticeUserLoginTitle.bottomAnchor, constant: LoginResources.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: LoginResources.Constraint.passFieldTopConstraint).isActive = true
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
                self?.logintBtn.bounce(completion: {
                    guard let `self` = self else { return }
                    let tabbarVC = TabBarController(calendar: DisplayCalendarViewController(), diary: DiaryGroupViewController(), mypage: MypageViewController())
                    `self`.present(tabbarVC, animated: true)
                })
            })
            .disposed(by: disposeBag)
        
        reissuePass.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.reissuePass.bounce(completion: {
                    guard let navi = self?.navigationController else { return }
                    navi.pushViewController(RemindPassViewController(), animated: true)
                })
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
