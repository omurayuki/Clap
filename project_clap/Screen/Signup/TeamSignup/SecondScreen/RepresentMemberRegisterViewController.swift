import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class RepresentMemberRegisterViewController: UIViewController {
    
    private var viewModel: RepresentMemberRegisterViewModel?
    private let disposeBag = DisposeBag()
    let activityIndicator = UIActivityIndicatorView()
    let teamId = RandomString.generateRandomString()
    
    private lazy var ui: RepresentMemberRegisterUI = {
        let ui = RepresentMemberRegisterUIImpl()
        ui.viewController = self
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
        viewModel = RepresentMemberRegisterViewModel(nameField: ui.nameField.rx.text.orEmpty.asObservable(),
                                                     mailField: ui.mailField.rx.text.orEmpty.asObservable(),
                                                     passField: ui.passField.rx.text.orEmpty.asObservable(),
                                                     rePassField: ui.rePassField.rx.text.orEmpty.asObservable(),
                                                     positionField: ui.representMemberPosition.rx.text.orEmpty.asObservable(),
                                                     yearField: ui.representMemberYear.rx.text.orEmpty.asObservable(),
                                                     registBtn: ui.teamRegistBtn.rx.tap.asObservable())
        setupViewModel()
        ui.setupToolBar(ui.representMemberPosition,
                        type: .position,
                        toolBar: ui.positionToolBar,
                        content: viewModel?.outputs.positionArr ?? [R.string.locarizable.empty()],
                        vc: self)
        ui.setupToolBar(ui.representMemberYear,
                        type: .year,
                        toolBar: ui.yearToolBar,
                        content: viewModel?.outputs.yearArr ?? [R.string.locarizable.empty()],
                        vc: self)
    }
}

extension RepresentMemberRegisterViewController {
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.teamRegistBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.teamRegistBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.ui.teamRegistBtn.bounce(completion: {
                    self?.showIndicator()
                    self?.viewModel?.saveToSingleton(name: self?.ui.nameField.text ?? "",
                                          mail: self?.ui.mailField.text ?? "",
                                          representMemberPosition: self?.ui.representMemberPosition.text ?? "",
                                          representMemberYear: self?.ui.representMemberYear.text ?? "")
                    SignupRepositoryImpl.signup(email: self?.ui.mailField.text ?? "", pass: self?.ui.passField.text ?? "", completion: { uid in
                        SignupRepositoryImpl.saveTeamData(teamId: self?.teamId ?? "",
                                                          team: TeamSignupSingleton.sharedInstance.team,
                                                          grade: TeamSignupSingleton.sharedInstance.grade,
                                                          sportsKind: TeamSignupSingleton.sharedInstance.sportsKind)
                        let realm = try? Realm()
                        let results = realm?.objects(User.self)
                        SignupRepositoryImpl.registUserWithTeam(teamId: self?.teamId ?? "",
                                                                uid: results?.first?.uid ?? "")
                        SignupRepositoryImpl.saveUserData(user: results?.last?.uid ?? "",
                                                          teamId: self?.teamId ?? "",
                                                          name: TeamSignupSingleton.sharedInstance.name,
                                                          role: TeamSignupSingleton.sharedInstance.representMemberPosition,
                                                          mail: self?.ui.mailField.text ?? "",
                                                          team: TeamSignupSingleton.sharedInstance.team,
                                                          completion: {
                                                            //saveToSingletonを３カ所で書いている
                                                            self?.viewModel?.saveToSingleton(uid: uid ?? "", completion: {
                                                                self?.hideIndicator()
                                                                self?.routing.showTabBar(uid: UIDSingleton.sharedInstance.uid)
                                                            })
                        })
                    })
                })
            }).disposed(by: disposeBag)
        
        ui.positionDoneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.representMemberPosition.isFirstResponder {
                    self?.ui.representMemberPosition.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.yearDoneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.representMemberYear.isFirstResponder {
                    self?.ui.representMemberYear.resignFirstResponder()
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

extension RepresentMemberRegisterViewController: IndicatorShowable {}
