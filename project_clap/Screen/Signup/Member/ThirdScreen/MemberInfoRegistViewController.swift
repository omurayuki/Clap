import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemberInfoRegistViewController: UIViewController {
    
    private struct Constants {
        struct Constraint {
            static let userPhotoRegistBtnTopConstraint: CGFloat = 30
            static let nameFieldtopConstraint: CGFloat = 30
            static let mailFieldTopConstraint: CGFloat = 25
            static let passFieldTopConstraint: CGFloat = 25
            static let rePassFieldTopConstraint: CGFloat = 25
            static let stackTopConstraint: CGFloat = 25
            static let MemberPositionHeightConstraint: CGFloat = 20
            static let memberPositionTopConstraint: CGFloat = 25
        }
        
        struct View {
            static let BtnCornerRadius: CGFloat = 15
            static let toolBarHeight: CGFloat = 44
            static let pickerNumberOfComponents = 1
        }
    }
    
    private let positionArr = [
        R.string.locarizable.empty(), R.string.locarizable.player(), R.string.locarizable.manager(),
        R.string.locarizable.boss(), R.string.locarizable.department(), R.string.locarizable.staff()
    ]
    
    private let disposeBag = DisposeBag()
    private var viewModel: MemberInfoRegisterViewModel?
    
    private lazy var noticeUserRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.notice_user_regist()
        label.textColor = AppResources.ColorResources.baseColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        field.isSecureTextEntry = true
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var rePassField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.remain_password()
        field.clearButtonMode = .always
        field.isSecureTextEntry = true
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var memberPosition: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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
    
    private lazy var memberRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.regist(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.regist_user()
        viewModel = MemberInfoRegisterViewModel(nameField: nameField.rx.text.orEmpty.asObservable(), mailField: mailField.rx.text.orEmpty.asObservable(), passField: passField.rx.text.orEmpty.asObservable(), rePassField: rePassField.rx.text.orEmpty.asObservable(), positionField: memberPosition.rx.text.orEmpty.asObservable(), registBtn: memberRegistBtn.rx.tap.asObservable())
        setupToolBar(memberPosition, toolBar: positionToolBar, content: positionArr)
        setupUI()
        setupViewModel()
    }
}

extension MemberInfoRegistViewController {
    private func setupUI() {
        view.addSubview(noticeUserRegistTitle)
        noticeUserRegistTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeUserRegistTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(nameField)
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: noticeUserRegistTitle.bottomAnchor, constant: Constants.Constraint.nameFieldtopConstraint).isActive = true
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
        view.addSubview(memberPosition)
        memberPosition.topAnchor.constraint(equalTo: rePassField.bottomAnchor, constant: Constants.Constraint.memberPositionTopConstraint).isActive = true
        memberPosition.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 3).isActive = true
        memberPosition.heightAnchor.constraint(equalToConstant: Constants.Constraint.MemberPositionHeightConstraint).isActive = true
        memberPosition.leftAnchor.constraint(equalTo: rePassField.leftAnchor).isActive = true
        view.addSubview(memberRegistBtn)
        memberRegistBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        memberRegistBtn.topAnchor.constraint(equalTo: memberPosition.bottomAnchor, constant: view.bounds.size.width / 3).isActive = true
        memberRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 2).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isRegistBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.memberRegistBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)
        
        memberRegistBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                print("遷移する")
            })
            .disposed(by: disposeBag)
    }
    
    private func getPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        return pickerView
    }
    
    private func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>) {
        textField.inputView = getPickerView()
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
    
    @objc private func tappedPosionBtn(sender: UIBarButtonItem) {
        if memberPosition.isFirstResponder {
            memberPosition.resignFirstResponder()
        }
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

extension MemberInfoRegistViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Constants.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positionArr.count
    }
}

extension MemberInfoRegistViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positionArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        memberPosition.text = positionArr[row]
    }
}
