import Foundation
import RxSwift
import RxCocoa

class MypageEditViewController: UIViewController {
    
    var recievedUid: String
    private let disposeBag = DisposeBag()
    let activityIndicator = UIActivityIndicatorView()
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
    
    init(uid: String) {
        recievedUid = uid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.setupInsideStack(vc: self)
        viewModel = MypageEditViewModel(belongField: ui.belongTeamField.rx.text.orEmpty.asObservable(),
                                        positionField: ui.positionField.rx.text.orEmpty.asObservable(),
                                        mailField: ui.mailField.rx.text.orEmpty.asObservable())
        ui.setupToolBar(ui.positionField,
                        toolBar: ui.positionToolBar,
                        content: viewModel?.outputs.positionArr ?? [R.string.locarizable.empty()],
                        vc: self)
        setupViewModel()
    }
}

extension MypageEditViewController {
    
    private func setupViewModel() {
        
        viewModel?.outputs.isSaveBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.saveBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.doneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.positionField.isFirstResponder {
                    self?.ui.positionField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.saveBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.saveBtn.bounce(completion: {
                guard let this = self else { return }
                this.showIndicator()
                // subscribeの中にsubscribe + updateDataをcontrollerにベタ書きしてしまっている
                MypageRepositoryImpl.updateEmail(email: this.ui.mailField.text ?? "")
                MypageRepositoryImpl().updateMypageData(uid: self?.recievedUid ?? "", updateData: ["team": this.ui.belongTeamField.text ?? "",
                                                                                                   "role": this.ui.positionField.text ?? "",
                                                                                                   "mail": this.ui.mailField.text ?? ""])
                    .subscribe { single in
                        switch single {
                        case .success(_):
                            this.hideIndicator(completion: { this.routing.showPrev(vc: this) })
                        case .error(let error):
                            this.hideIndicator(completion: { print(error.localizedDescription) })
                        }
                    }.disposed(by: this.disposeBag)
                })
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

extension MypageEditViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return MemberInfoRegisterResources.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.outputs.positionArr.count ?? 0
    }
}

extension MypageEditViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.outputs.positionArr[row] ?? R.string.locarizable.empty()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ui.positionField.text = viewModel?.outputs.positionArr[row] ?? R.string.locarizable.empty()
    }
}

extension MypageEditViewController: IndicatorShowable {}
