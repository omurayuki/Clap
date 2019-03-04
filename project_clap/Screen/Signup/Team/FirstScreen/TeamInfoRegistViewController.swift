import Foundation
import UIKit
import RxSwift
import RxCocoa

class  TeamInfoRegistViewController: UIViewController {
    
    private enum PickerType {
        case grade
        case sports
    }
    
    private struct Constants {
        struct Constraint {
            static let gradeFieldTopConstraint: CGFloat = 35
            static let sportsKindFieldTopConstraint: CGFloat = 35
        }
        
        struct View {
            static let nextBtnCornerRadius: CGFloat = 15
            static let toolBarHeight: CGFloat = 44
            static let pickerNumberOfComponents = 1
        }
    }
    
    private var viewModel: TeamInfoRegistViewModel?
    private let disposeBag = DisposeBag()
    
    private let gradeArr = [
        R.string.locarizable.empty(), R.string.locarizable.junior_high_school(),
        R.string.locarizable.high_school(), R.string.locarizable.university(), R.string.locarizable.social()
    ]
    
    private let sportsKindArr = [
        R.string.locarizable.empty(), R.string.locarizable.rugby(),
        R.string.locarizable.base_ball(), R.string.locarizable.soccer(),
        R.string.locarizable.basket_ball(), R.string.locarizable.kendo(), R.string.locarizable.judo()
    ]
    
    private lazy var noticeTeamInfoRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.regist_team_info()
        label.textColor = AppResources.ColorResources.baseColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamIdField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.team_id()
        field.clearButtonMode = .always
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var gradeField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var sportsKindField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.next(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.nextBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gradeToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: Constants.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedGradeBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = UIColor.white
        return accessoryToolbar
    }()
    
    private lazy var sportsKindToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: Constants.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedSportsKindBtn(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = UIColor.white
        return accessoryToolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.team_info_title()
        setupToolBar(gradeField, type: .grade, toolBar: gradeToolBar, content: gradeArr)
        setupToolBar(sportsKindField, type: .sports, toolBar: sportsKindToolBar, content: sportsKindArr)
        viewModel = TeamInfoRegistViewModel(teamIdField: teamIdField.rx.text.orEmpty.asObservable(), gradeField: gradeField.rx.text.orEmpty.asObservable(), sportsKindField: sportsKindField.rx.text.orEmpty.asObservable())
        setupUI()
        setupViewModel()
    }
}

extension TeamInfoRegistViewController {
    private func setupUI() {
        view.addSubview(noticeTeamInfoRegistTitle)
        noticeTeamInfoRegistTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeTeamInfoRegistTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(teamIdField)
        teamIdField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamIdField.topAnchor.constraint(equalTo: noticeTeamInfoRegistTitle.bottomAnchor, constant: view.bounds.size.width / 4).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(gradeField)
        gradeField.topAnchor.constraint(equalTo: teamIdField.bottomAnchor, constant: Constants.Constraint.gradeFieldTopConstraint).isActive = true
        gradeField.leftAnchor.constraint(equalTo: teamIdField.leftAnchor).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(sportsKindField)
        sportsKindField.topAnchor.constraint(equalTo: gradeField.bottomAnchor, constant: Constants.Constraint.sportsKindFieldTopConstraint).isActive = true
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
        return Constants.View.pickerNumberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is GradePickerView: return gradeArr.count
        case is SportsKindPickerView: return sportsKindArr.count
        default: return 0
        }
    }
}

extension TeamInfoRegistViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case is GradePickerView: return gradeArr[row]
        case is SportsKindPickerView: return sportsKindArr[row]
        default: return Optional<String>("")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case is GradePickerView: gradeField.text = gradeArr[row]
        case is SportsKindPickerView: sportsKindField.text = sportsKindArr[row]
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
