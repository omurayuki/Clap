import Foundation
import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import FirebaseStorage
import FirebaseAuth

class RepresentMemberRegisterViewController: UIViewController {
    
    private var viewModel: RepresentMemberRegisterViewModel!
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
                        content: viewModel?.outputs.positionArr.value ?? [R.string.locarizable.empty()],
                        vc: self)
        ui.setupToolBar(ui.representMemberYear,
                        type: .year,
                        toolBar: ui.yearToolBar,
                        content: viewModel?.outputs.yearArr.value ?? [R.string.locarizable.empty()],
                        vc: self)
    }
}

extension RepresentMemberRegisterViewController {
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isValid in
                isValid ? self?.ui.teamRegistBtn.setupAnimation() : self?.ui.teamRegistBtn.teardownAnimation()
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.outputs.isOverName
            .distinctUntilChanged()
            .subscribe(onNext: { bool in
                if bool {
                    self.ui.nameField.backgroundColor = AppResources.ColorResources.appCommonClearOrangeColor
                    AlertController.showAlertMessage(alertType: .overChar, viewController: self)
                } else {
                    self.ui.nameField.backgroundColor = .white
                }
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.outputs.isOverPass
            .distinctUntilChanged()
            .subscribe(onNext: { bool in
                if bool {
                    self.ui.passField.backgroundColor = AppResources.ColorResources.appCommonClearOrangeColor
                    AlertController.showAlertMessage(alertType: .overChar, viewController: self)
                } else {
                    self.ui.passField.backgroundColor = .white
                }
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.outputs.isOverRepass
            .distinctUntilChanged()
            .subscribe(onNext: { bool in
                if bool {
                    self.ui.rePassField.backgroundColor = AppResources.ColorResources.appCommonClearOrangeColor
                    AlertController.showAlertMessage(alertType: .overChar, viewController: self)
                } else {
                    self.ui.rePassField.backgroundColor = .white
                }
            }).disposed(by: viewModel.disposeBag)
        
        ui.teamRegistBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.ui.teamRegistBtn.bounce(completion: { self?.showIndicator() })
            }).disposed(by: viewModel.disposeBag)
        
        ui.teamRegistBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] _ -> Single<AuthDataResult> in
                    self.viewModel.signup(email: self.ui.mailField.text ?? "",
                                           pass: self.ui.passField.text ?? "")
            }
            .subscribe(onNext: { [weak self] response in
                self?.viewModel.saveUserData(uid: response.user.uid,
                                             email: response.user.email ?? "",
                                             completion: { error in
                    if let _ = error {
                        AlertController.showAlertMessage(alertType: .loginFailed, viewController: self ?? UIViewController())
                        return
                    }
                })
                self?.viewModel?.saveToSingleton(name: self?.ui.nameField.text ?? "",
                                      mail: self?.ui.mailField.text ?? "",
                                      representMemberPosition: self?.ui.representMemberPosition.text ?? "",
                                      representMemberYear: self?.ui.representMemberYear.text ?? "")
                self?.viewModel?.saveTeamData(teamId: self?.teamId ?? "",
                                              team: TeamSignupSingleton.sharedInstance.team,
                                              grade: TeamSignupSingleton.sharedInstance.grade,
                                              sportsKind: TeamSignupSingleton.sharedInstance.sportsKind)
                let results = self?.viewModel.getUserData()
                self?.viewModel?.registUserWithTeam(teamId: self?.teamId ?? "",
                                                    uid: results?.last?.uid ?? "")
                self?.viewModel?.saveUserData(uid: results?.last?.uid ?? "", teamId: self?.teamId ?? "",
                                              name: TeamSignupSingleton.sharedInstance.name,
                                              role: TeamSignupSingleton.sharedInstance.representMemberPosition,
                                              mail: self?.ui.mailField.text ?? "", team: TeamSignupSingleton.sharedInstance.team,
                                              completion: { _, error in
                    if let _ = error {
                        self?.hideIndicator()
                        AlertController.showAlertMessage(alertType: .loginFailed, viewController: self ?? UIViewController())
                        return
                    }
                    self?.viewModel?.saveToSingleton(uid: response.user.uid, completion: {
                        self?.hideIndicator()
                        self?.routing.showTabBar(uid: UserSingleton.sharedInstance.uid)
                    })
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.positionDoneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.representMemberPosition.isFirstResponder {
                    self?.ui.representMemberPosition.resignFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.yearDoneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.representMemberYear.isFirstResponder {
                    self?.ui.representMemberYear.resignFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.nameField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.nameField.isFirstResponder {
                    self?.ui.mailField.becomeFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.mailField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.mailField.isFirstResponder {
                    self?.ui.passField.becomeFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.passField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.passField.isFirstResponder {
                    self?.ui.rePassField.becomeFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.rePassField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.rePassField.isFirstResponder {
                    self?.ui.rePassField.resignFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: viewModel.disposeBag)
    }
}

extension RepresentMemberRegisterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return RepresentMemberRegisterResources.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is PositionPickerView: return viewModel?.outputs.positionArr.value.count ?? 0
        case is YearPickerView: return viewModel?.outputs.yearArr.value.count ?? 0
        default: return 0
        }
    }
}

extension RepresentMemberRegisterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case is PositionPickerView: return viewModel?.outputs.positionArr.value[row] ?? R.string.locarizable.empty()
        case is YearPickerView: return viewModel?.outputs.yearArr.value[row] ?? R.string.locarizable.empty()
        default: return Optional<String>("")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case is PositionPickerView: ui.representMemberPosition.text = viewModel?.outputs.positionArr.value[row]
        case is YearPickerView: ui.representMemberYear.text = viewModel?.outputs.yearArr.value[row]
        default: break
        }
    }
}

extension RepresentMemberRegisterViewController: IndicatorShowable {}
