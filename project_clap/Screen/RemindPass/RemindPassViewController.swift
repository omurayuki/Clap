import Foundation
import UIKit
import RxCocoa
import RxSwift

class RemindPassViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: RemindPassViewModel?
    
    private lazy var remindTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_remind_label()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.numberOfLines = RemindPassResources.View.titleNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.submit(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TeamInfoRegisterResources.View.nextBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RemindPassViewModel(emailField: emailField.rx.text.orEmpty.asObservable())
        setupUI()
        setupViewModel()
    }
}

extension RemindPassViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.password_settings()
        view.addSubview(remindTitle)
        remindTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        remindTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        remindTitle.widthAnchor.constraint(equalToConstant: view.bounds.size.width - RemindPassResources.Constraint.remindTitleWidthConstraint).isActive = true
        view.addSubview(emailField)
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(submitBtn)
        submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        submitBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isSubmitBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.submitBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)
    }
}

extension RemindPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
