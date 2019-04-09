import Foundation
import UIKit
import RxCocoa
import RxSwift
import Firebase
import FirebaseAuth

class LoginViewCountroller: UIViewController {
    
    private var viewModel: LoginViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var ui: LoginUI = {
        let ui = LoginUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: LoginRouting = {
       let routing = LoginRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        viewModel = LoginViewModel(emailField: ui.mailField.rx.text.orEmpty.asDriver(),
                                   passField: ui.passField.rx.text.orEmpty.asDriver(),
                                   loginTapped: ui.logintBtn.rx.tap.asDriver())
        setupViewModel()
    }
}

extension LoginViewCountroller {
    
    private func setupViewModel() {
        viewModel?.outputs.isLoginBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.logintBtn.isHidden = !isValid
            }).disposed(by: viewModel.disposeBag)
        
        ui.logintBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.showIndicator()
                this.ui.logintBtn.bounce(completion: {
                    this.viewModel?.login(mail: this.ui.mailField.text ?? "", pass: this.ui.passField.text ?? "", completion: { (uid, error) in
                        if let _ = error {
                            self?.hideIndicator()
                            AlertController.showAlertMessage(alertType: .loginFailed, viewController: this)
                        }
                        self?.viewModel?.saveToSingleton(uid: uid ?? "", completion: {
                            self?.hideIndicator(completion: { this.routing.showTabBar(uid: UIDSingleton.sharedInstance.uid) })
                        })
                    })
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.reissuePass.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.reissuePass.bounce(completion: {
                    self?.routing.showRemindPass()
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.mailField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.mailField.isFirstResponder {
                    self?.ui.passField.resignFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.passField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.passField.isFirstResponder {
                    self?.ui.passField.resignFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: viewModel.disposeBag)
    }
}

extension LoginViewCountroller: IndicatorShowable {}
