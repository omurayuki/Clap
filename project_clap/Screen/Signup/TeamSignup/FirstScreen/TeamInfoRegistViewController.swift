import Foundation
import UIKit
import RxSwift
import RxCocoa

class  TeamInfoRegistViewController: UIViewController {
    
    private enum PickerType {
        case grade
        case sports
    }
    
    private var viewModel: TeamInfoRegistViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var noticeTeamInfoRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.regist_team_info()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamIdField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.team_id()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var gradeField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var sportsKindField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.next(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TeamInfoRegisterResources.View.nextBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gradeToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedGradeBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private lazy var sportsKindToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedSportsKindBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TeamInfoRegistViewModel(teamIdField: teamIdField.rx.text.orEmpty.asObservable(), gradeField: gradeField.rx.text.orEmpty.asObservable(), sportsKindField: sportsKindField.rx.text.orEmpty.asObservable())
        setupToolBar(gradeField, type: .grade, toolBar: gradeToolBar, content: viewModel?.outputs.gradeArr ?? [R.string.locarizable.empty()])
        setupToolBar(sportsKindField, type: .sports, toolBar: sportsKindToolBar, content: viewModel?.outputs.sportsKindArr ?? [R.string.locarizable.empty()])
        setupUI()
        setupViewModel()
    }
}

extension TeamInfoRegistViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.team_info_title()
        view.addSubview(noticeTeamInfoRegistTitle)
        noticeTeamInfoRegistTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeTeamInfoRegistTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(teamIdField)
        teamIdField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamIdField.topAnchor.constraint(equalTo: noticeTeamInfoRegistTitle.bottomAnchor, constant: view.bounds.size.width / 4).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(gradeField)
        gradeField.topAnchor.constraint(equalTo: teamIdField.bottomAnchor, constant: TeamInfoRegisterResources.Constraint.gradeFieldTopConstraint).isActive = true
        gradeField.leftAnchor.constraint(equalTo: teamIdField.leftAnchor).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(sportsKindField)
        sportsKindField.topAnchor.constraint(equalTo: gradeField.bottomAnchor, constant: TeamInfoRegisterResources.Constraint.sportsKindFieldTopConstraint).isActive = true
        sportsKindField.leftAnchor.constraint(equalTo: teamIdField.leftAnchor).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(nextBtn)
        nextBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextBtn.topAnchor.constraint(equalTo: sportsKindField.bottomAnchor, constant: view.bounds.size.width / 2).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isNextBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                print(isValid)
                self?.nextBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)

        nextBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let navi = self?.navigationController else { return }
                navi.pushViewController(RepresentMemberRegisterViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func getPickerView(type: PickerType) -> UIPickerView {
        var pickerView = UIPickerView()
        switch type {
        case .grade: pickerView = GradePickerView()
        case .sports: pickerView = SportsKindPickerView()
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
    func tappedGradeBtn(sender: UIBarButtonItem) {
        if gradeField.isFirstResponder {
            gradeField.resignFirstResponder()
        }
    }
    
    @objc
    func tappedSportsKindBtn(sender: UIBarButtonItem) {
        if sportsKindField.isFirstResponder {
            sportsKindField.resignFirstResponder()
        }
    }
}

fileprivate class GradePickerView: UIPickerView {}
fileprivate class SportsKindPickerView: UIPickerView {}

extension TeamInfoRegistViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return TeamInfoRegisterResources.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is GradePickerView: return viewModel?.outputs.gradeArr.count ?? 0
        case is SportsKindPickerView: return viewModel?.outputs.sportsKindArr.count ?? 0
        default: return 0
        }
    }
}

extension TeamInfoRegistViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case is GradePickerView: return viewModel?.outputs.gradeArr[row] ?? R.string.locarizable.empty()
        case is SportsKindPickerView: return viewModel?.outputs.sportsKindArr[row] ?? R.string.locarizable.empty()
        default: return Optional<String>("")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case is GradePickerView: gradeField.text = viewModel?.outputs.gradeArr[row]
        case is SportsKindPickerView: sportsKindField.text = viewModel?.outputs.sportsKindArr[row]
        default: break
        }
    }
}

extension TeamInfoRegistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
