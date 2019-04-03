import Foundation
import RxCocoa
import RxSwift

class RemindPassViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: RemindPassViewModel?
    
    private lazy var ui: RemindPassUI = {
        let ui = RemindPassUIImple()
        ui.viewController = self
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        viewModel = RemindPassViewModel(emailField: ui.emailField.rx.text.orEmpty.asObservable())
        setupViewModel()
    }
}

extension RemindPassViewController {
    
    private func setupViewModel() {
        viewModel?.outputs.isSubmitBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.submitBtn.isHidden = !isValid
            }).disposed(by: disposeBag)

        ui.emailField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.emailField.isFirstResponder {
                    self?.ui.emailField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
        
        ui.submitBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.ui.submitBtn.bounce(completion: {
                    Firebase.fireAuth.sendPasswordReset(withEmail: this.ui.emailField.text ?? "", completion: { (error) in
                        if let _ = error {
                            AlertController.showAlertMessage(alertType: .sendMailFailed, viewController: this)
                            return
                        }
                        AlertController.showAlertMessage(alertType: .sendMailSuccess, viewController: this)
                    })
                })
            }).disposed(by: disposeBag)
    }
}
