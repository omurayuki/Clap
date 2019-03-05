import Foundation
import UIKit
import RxSwift
import RxCocoa

class RepresentMemberRegisterViewController: UIViewController {
    
    private enum PickerType {
        case position
        case year
    }
    
    private var viewModel: RepresentMemberRegisterViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var noticeUserRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_user_regist()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userPhotoRegistBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.name()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var rePassField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.remain_password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var representMemberPosition: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var representMemberYear: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(representMemberPosition)
        stack.addArrangedSubview(representMemberYear)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var teamRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.regist(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = RepresentMemberRegisterResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var positionToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: RepresentMemberRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedPosionBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private lazy var yearToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: RepresentMemberRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedYearBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar(representMemberPosition, type: .position, toolBar: positionToolBar, content: viewModel?.outputs.positionArr ?? [R.string.locarizable.empty()])
        setupToolBar(representMemberYear, type: .year, toolBar: yearToolBar, content: viewModel?.outputs.yearArr ?? [R.string.locarizable.empty()])
        viewModel = RepresentMemberRegisterViewModel(nameField: nameField.rx.text.orEmpty.asObservable(), mailField: mailField.rx.text.orEmpty.asObservable(), passField: passField.rx.text.orEmpty.asObservable(), rePassField: rePassField.rx.text.orEmpty.asObservable(), positionField: representMemberPosition.rx.text.orEmpty.asObservable(), yearField: representMemberYear.rx.text.orEmpty.asObservable(), registBtn: teamRegistBtn.rx.tap.asObservable())
        setupUI()
        setupInsideStack()
        setupViewModel()
    }
}

extension RepresentMemberRegisterViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.regist_user()
        view.addSubview(noticeUserRegistTitle)
        noticeUserRegistTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeUserRegistTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(userPhotoRegistBtn)
        userPhotoRegistBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userPhotoRegistBtn.topAnchor.constraint(equalTo: noticeUserRegistTitle.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.userPhotoRegistBtnTopConstraint).isActive = true
        userPhotoRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 7).isActive = true
        userPhotoRegistBtn.heightAnchor.constraint(equalToConstant: view.bounds.size.width / 7).isActive = true
        view.addSubview(nameField)
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: userPhotoRegistBtn.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.nameFieldtopConstraint).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.passFieldTopConstraint).isActive = true
        passField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(rePassField)
        rePassField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rePassField.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.rePassFieldTopConstraint).isActive = true
        rePassField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: rePassField.bottomAnchor, constant: RepresentMemberRegisterResources.Constraint.stackTopConstraint).isActive = true
        view.addSubview(teamRegistBtn)
        teamRegistBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamRegistBtn.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: view.bounds.size.width / 3).isActive = true
        teamRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupInsideStack() {
        representMemberPosition.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 6).isActive = true
        representMemberPosition.heightAnchor.constraint(equalToConstant: RepresentMemberRegisterResources.Constraint.representMemberPositionHeightConstraint).isActive = true
        representMemberYear.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 6).isActive = true
        representMemberYear.heightAnchor.constraint(equalToConstant: RepresentMemberRegisterResources.Constraint.representMemberYearHeightConstraint).isActive = true
        representMemberYear.leftAnchor.constraint(equalTo: representMemberPosition.rightAnchor, constant: view.bounds.size.width / 3).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                print(isValid)
                self?.teamRegistBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)
        
        teamRegistBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                let tabbarVC = TabBarController(calendar: DisplayCalendarViewController(), diary: DiaryGroupViewController(), mypage: MypageViewController())
                `self`.present(tabbarVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func getPickerView(type: PickerType) -> UIPickerView {
        var pickerView = UIPickerView()
        switch type {
        case .position: pickerView = PositionPickerView()
        case .year: pickerView = YearPickerView()
        }
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }
    
    private func setupToolBar(_ textField: UITextField, type: PickerType, toolBar: UIToolbar, content: Array<String>) {
        textField.inputView = getPickerView(type: type)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
    
    @objc
    func tappedPosionBtn(sender: UIBarButtonItem) {
        if representMemberPosition.isFirstResponder {
            representMemberPosition.resignFirstResponder()
        }
    }
    
    @objc
    func tappedYearBtn(sender: UIBarButtonItem) {
        if representMemberYear.isFirstResponder {
            representMemberYear.resignFirstResponder()
        }
    }
}

fileprivate class PositionPickerView: UIPickerView {}
fileprivate class YearPickerView: UIPickerView {}

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
        case is PositionPickerView: representMemberPosition.text = viewModel?.outputs.positionArr[row]
        case is YearPickerView: representMemberYear.text = viewModel?.outputs.yearArr[row]
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
