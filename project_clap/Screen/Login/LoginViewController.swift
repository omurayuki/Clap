import Foundation
import UIKit
import RxCocoa
import RxSwift

class LoginViewCountroller: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel?
    
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
        viewModel = LoginViewModel(emailField: ui.mailField.rx.text.orEmpty.asDriver(), passField: ui.passField.rx.text.orEmpty.asDriver(), loginTapped: ui.logintBtn.rx.tap.asDriver())
        setupViewModel()
    }
}

extension LoginViewCountroller {
    
    private func setupViewModel() {
        viewModel?.outputs.isLoginBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.logintBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.logintBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.logintBtn.bounce(completion: {
                    self?.routing.showTabBar()
                })
            }).disposed(by: disposeBag)
        
        ui.reissuePass.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.reissuePass.bounce(completion: {
                    self?.routing.showRemindPass()
                })
            }).disposed(by: disposeBag)
        
        ui.mailField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.mailField.isFirstResponder {
                    self?.ui.passField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.passField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.passField.isFirstResponder {
                    self?.ui.passField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
}
