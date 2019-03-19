import Foundation
import RxSwift
import RxCocoa

class RepresentMemberRegisterViewController: UIViewController {
    
    private var viewModel: RepresentMemberRegisterViewModel?
    private let disposeBag = DisposeBag()
    let positionDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
    let yearDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
    
    private lazy var ui: RepresentMemberRegisterUI = {
        let ui = RepresentMemberRegisterUIImpl()
        ui.viewController = self
        ui.nameField.delegate = self
        ui.mailField.delegate = self
        ui.passField.delegate = self
        ui.rePassField.delegate = self
        return ui
    }()
    
    private lazy var routing: RepresentMemberRegisterRouting = {
        let routing = RepresentMemberRegisterRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(storeName: R.string.locarizable.regist_user())
        ui.setupInsideStack(vc: self)
        viewModel = RepresentMemberRegisterViewModel(nameField: ui.nameField.rx.text.orEmpty.asObservable(), mailField: ui.mailField.rx.text.orEmpty.asObservable(), passField: ui.passField.rx.text.orEmpty.asObservable(), rePassField: ui.rePassField.rx.text.orEmpty.asObservable(), positionField: ui.representMemberPosition.rx.text.orEmpty.asObservable(), yearField: ui.representMemberYear.rx.text.orEmpty.asObservable(), registBtn: ui.teamRegistBtn.rx.tap.asObservable())
        setupViewModel()
        ui.positionToolBar.items = [positionDoneButton]
        ui.yearToolBar.items = [yearDoneButton]
        ui.setupToolBar(ui.representMemberPosition, type: .position, toolBar: ui.positionToolBar, content: viewModel?.outputs.positionArr ?? [R.string.locarizable.empty()], vc: self)
        ui.setupToolBar(ui.representMemberYear, type: .year, toolBar: ui.yearToolBar, content: viewModel?.outputs.yearArr ?? [R.string.locarizable.empty()], vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension RepresentMemberRegisterViewController {
    
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.teamRegistBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.teamRegistBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.teamRegistBtn.bounce(completion: {
                    self?.routing.showTabBar()
                })
            }).disposed(by: disposeBag)
        
        positionDoneButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.representMemberPosition.isFirstResponder {
                    self?.ui.representMemberPosition.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        yearDoneButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.representMemberYear.isFirstResponder {
                    self?.ui.representMemberYear.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
    }
}

extension RepresentMemberRegisterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return RepresentMemberRegisterResources.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is PositionPickerView: return viewModel?.outputs.positionArr.count ?? 0
        case is YearPickerView: return viewModel?.outputs.yearArr.count ?? 0
        default: return 0
        }
    }
}

extension RepresentMemberRegisterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case is PositionPickerView: return viewModel?.outputs.positionArr[row] ?? R.string.locarizable.empty()
        case is YearPickerView: return viewModel?.outputs.yearArr[row] ?? R.string.locarizable.empty()
        default: return Optional<String>("")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case is PositionPickerView: ui.representMemberPosition.text = viewModel?.outputs.positionArr[row]
        case is YearPickerView: ui.representMemberYear.text = viewModel?.outputs.yearArr[row]
        default: break
        }
    }
}

extension RepresentMemberRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
