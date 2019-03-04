import Foundation
import UIKit
import RxSwift
import RxCocoa

class RepresentMemberRegisterViewController: UIViewController {
    
    private enum PickerType {
        case position
        case year
    }
    
    private struct Constants {
        struct Constraint {
            static let userPhotoRegistBtnTopConstraint: CGFloat = 30
            static let nameFieldtopConstraint: CGFloat = 30
            static let mailFieldTopConstraint: CGFloat = 25
            static let passFieldTopConstraint: CGFloat = 25
            static let rePassFieldTopConstraint: CGFloat = 25
            static let stackTopConstraint: CGFloat = 25
            static let representMemberPositionHeightConstraint: CGFloat = 20
            static let representMemberYearHeightConstraint: CGFloat = 20
        }
        
        struct View {
            static let BtnCornerRadius: CGFloat = 15
            static let toolBarHeight: CGFloat = 44
            static let pickerNumberOfComponents = 1
        }
    }
    
    private var viewModel: RepresentMemberRegisterViewModel?
    private let disposeBag = DisposeBag()
    
    private let positionArr = [
        R.string.locarizable.position(),R.string.locarizable.player(), R.string.locarizable.leader(), R.string.locarizable.manager()
    ]
    private let yearArr = [
        R.string.locarizable.year(), R.string.locarizable.first_year_student(),
        R.string.locarizable.second_year_student(), R.string.locarizable.third_year_student(), R.string.locarizable.fourth_year_student()
    ]
    
    private lazy var noticeUserRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_user_regist()
        label.textColor = AppResources.ColorResources.baseColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userPhotoRegistBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.name()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mailField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.mail_address()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.password()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var rePassField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.remain_password()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var representMemberPosition: UITextField = {
        let field = UITextField()
        field.tintColor = .clear
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var representMemberYear: UITextField = {
        let field = UITextField()
        field.tintColor = .clear
        field.textAlignment = .center
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
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.BtnCornerRadius
        button.addTarget(self, action: #selector(showMainPage(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var positionToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: Constants.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedPosionBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = UIColor.white
        return accessoryToolbar
    }()
    
    private lazy var yearToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: Constants.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedYearBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = UIColor.white
        return accessoryToolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.represent_vc_title()
        setupToolBar(representMemberPosition, type: .position, toolBar: positionToolBar, content: positionArr)
        setupToolBar(representMemberYear, type: .year, toolBar: yearToolBar, content: yearArr)
        viewModel = RepresentMemberRegisterViewModel(nameField: nameField.rx.text.orEmpty.asObservable(), mailField: mailField.rx.text.orEmpty.asObservable(), passField: passField.rx.text.orEmpty.asObservable(), rePassField: rePassField.rx.text.orEmpty.asObservable(), registBtn: teamRegistBtn.rx.tap.asObservable())
        setupUI()
        setupInsideStack()
        setupViewModel()
    }
}

extension RepresentMemberRegisterViewController {
    private func setupUI() {
        view.addSubview(noticeUserRegistTitle)
        noticeUserRegistTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeUserRegistTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(userPhotoRegistBtn)
        userPhotoRegistBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userPhotoRegistBtn.topAnchor.constraint(equalTo: noticeUserRegistTitle.bottomAnchor, constant: Constants.Constraint.userPhotoRegistBtnTopConstraint).isActive = true
        userPhotoRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 7).isActive = true
        userPhotoRegistBtn.heightAnchor.constraint(equalToConstant: view.bounds.size.width / 7).isActive = true
        view.addSubview(nameField)
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: userPhotoRegistBtn.bottomAnchor, constant: Constants.Constraint.nameFieldtopConstraint).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(mailField)
        mailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: Constants.Constraint.mailFieldTopConstraint).isActive = true
        mailField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passField.topAnchor.constraint(equalTo: mailField.bottomAnchor, constant: Constants.Constraint.passFieldTopConstraint).isActive = true
        passField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(rePassField)
        rePassField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rePassField.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: Constants.Constraint.rePassFieldTopConstraint).isActive = true
        rePassField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: rePassField.bottomAnchor, constant: Constants.Constraint.stackTopConstraint).isActive = true
        view.addSubview(teamRegistBtn)
        teamRegistBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamRegistBtn.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: view.bounds.size.width / 3).isActive = true
        teamRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 2).isActive = true
    }
    
    private func setupInsideStack() {
        representMemberPosition.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 6).isActive = true
        representMemberPosition.heightAnchor.constraint(equalToConstant: Constants.Constraint.representMemberPositionHeightConstraint).isActive = true
        representMemberYear.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 6).isActive = true
        representMemberYear.heightAnchor.constraint(equalToConstant: Constants.Constraint.representMemberYearHeightConstraint).isActive = true
        representMemberYear.leftAnchor.constraint(equalTo: representMemberPosition.rightAnchor, constant: view.bounds.size.width / 3).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                print(isValid)
                self?.teamRegistBtn.isHidden = !isValid
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
    
    @objc
    func showMainPage(sender: UIButton) {
        print("signupinputにデータ突っ込んでvalidate? viewModelでvalidate?")
    }
}

fileprivate class PositionPickerView: UIPickerView {}
fileprivate class YearPickerView: UIPickerView {}

extension RepresentMemberRegisterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Constants.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is PositionPickerView: return positionArr.count
        case is YearPickerView: return yearArr.count
        default: return 0
        }
    }
}

extension RepresentMemberRegisterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case is PositionPickerView: return positionArr[row]
        case is YearPickerView: return yearArr[row]
        default: return Optional<String>("")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case is PositionPickerView: representMemberPosition.text = positionArr[row]
        case is YearPickerView: representMemberYear.text = yearArr[row]
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
