import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemberInfoRegistViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: MemberInfoRegisterViewModel?
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
    
    private lazy var ui: MemberInfoRegistUI = {
        let ui = MemberInfoRegistUIImpl()
        ui.nameField.delegate = self
        ui.mailField.delegate = self
        ui.passField.delegate = self
        ui.rePassField.delegate = self
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
        ui.positionToolBar.items = [doneButton]
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
        
        ui.memberRegistBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.memberRegistBtn.bounce(completion: {
                    self?.routing.showTabBar()
                })
            }).disposed(by: disposeBag)
        
        doneButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.memberPosition.isFirstResponder {
                    self?.ui.memberPosition.resignFirstResponder()
                }
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

extension MemberInfoRegistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
