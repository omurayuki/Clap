import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemberInfoRegistViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: MemberInfoRegisterViewModel?
    
    private lazy var ui: MemberInfoRegistUI = {
        let ui = MemberInfoRegistUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: MemberInfoRegistRouting = {
        let routing = MemberInfoRegistRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        viewModel = MemberInfoRegisterViewModel(nameField: ui.nameField.rx.text.orEmpty.asObservable(), mailField: ui.mailField.rx.text.orEmpty.asObservable(), passField: ui.passField.rx.text.orEmpty.asObservable(), rePassField: ui.rePassField.rx.text.orEmpty.asObservable(), positionField: ui.memberPosition.rx.text.orEmpty.asObservable(), registBtn: ui.memberRegistBtn.rx.tap.asObservable())
        ui.setupToolBar(ui.memberPosition, toolBar: ui.positionToolBar, content: viewModel?.outputs.positionArr ?? [R.string.locarizable.empty()], vc: self)
        setupViewModel()
    }
}

extension MemberInfoRegistViewController {
    
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.memberRegistBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.memberRegistBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.ui.memberRegistBtn.bounce(completion: {
                    self?.routing.showTabBar()
                })
            }).disposed(by: disposeBag)
        
        ui.doneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.memberPosition.isFirstResponder {
                    self?.ui.memberPosition.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.nameField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.nameField.isFirstResponder {
                    self?.ui.mailField.becomeFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.mailField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.mailField.isFirstResponder {
                    self?.ui.passField.becomeFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.passField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.passField.isFirstResponder {
                    self?.ui.rePassField.becomeFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.rePassField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.rePassField.isFirstResponder {
                    self?.ui.rePassField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
}

extension MemberInfoRegistViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return MemberInfoRegisterResources.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.outputs.positionArr.count ?? 0
    }
}

extension MemberInfoRegistViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.outputs.positionArr[row] ?? R.string.locarizable.empty()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ui.memberPosition.text = viewModel?.outputs.positionArr[row] ?? R.string.locarizable.empty()
    }
}
