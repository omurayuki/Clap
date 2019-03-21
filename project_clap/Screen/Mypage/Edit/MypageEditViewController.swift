import Foundation
import RxSwift
import RxCocoa

class MypageEditViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: MypageEditViewModel?
    
    private lazy var ui: MypageEditUI = {
        let ui = MypageEditUIImple()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: MypageEditRouting = {
        let routing = MypageEditRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.setupInsideStack(vc: self)
        viewModel = MypageEditViewModel(belongField: ui.belongTeamField.rx.text.orEmpty.asObservable(), positionField: ui.positionField.rx.text.orEmpty.asObservable(), mailField: ui.mailField.rx.text.orEmpty.asObservable())
        setupViewModel()
    }
}

extension MypageEditViewController {
    
    private func setupViewModel() {
        viewModel?.outputs.isSaveBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.saveBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.saveBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                self?.routing.showPrev(vc: this)
            }).disposed(by: disposeBag)
        
        ui.belongTeamField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.belongTeamField.isFirstResponder {
                    self?.ui.positionField.becomeFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.positionField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.positionField.isFirstResponder {
                    self?.ui.mailField.becomeFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.mailField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.mailField.isFirstResponder {
                    self?.ui.mailField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind{ [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
}
