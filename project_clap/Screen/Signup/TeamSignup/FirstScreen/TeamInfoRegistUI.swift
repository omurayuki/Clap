import Foundation
import UIKit

protocol TeamInfoRegistUI: UI {
    var noticeTeamInfoRegistTitle: UILabel { get }
    var teamIdField: CustomTextField { get }
    var gradeField: CustomTextField { get }
    var sportsKindField: CustomTextField { get }
    var nextBtn: UIButton { get }
    var gradeToolBar: UIToolbar { get }
    var sportsKindToolBar: UIToolbar { get }
    
    func setup(storeName: String)
    func getPickerView(type: TeamInfoRegistPickerType, vc: UIViewController) -> UIPickerView
    func setupToolBar(_ textField: UITextField, type: TeamInfoRegistPickerType, toolBar: UIToolbar, content: Array<String>, vc: UIViewController)
}

final class TeamInfoRegistUIImpl: TeamInfoRegistUI {
    
    weak var viewController: UIViewController?
    
    private(set) var noticeTeamInfoRegistTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.regist_team_info()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var teamIdField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.team_id()
        field.clearButtonMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var gradeField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var sportsKindField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.next(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TeamInfoRegisterResources.View.nextBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var gradeToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private(set) var sportsKindToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
}

extension TeamInfoRegistUIImpl {
    func setup(storeName: String) {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.navigationItem.title = storeName
        vc.view.addSubview(noticeTeamInfoRegistTitle)
        noticeTeamInfoRegistTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        noticeTeamInfoRegistTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(teamIdField)
        teamIdField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        teamIdField.topAnchor.constraint(equalTo: noticeTeamInfoRegistTitle.bottomAnchor, constant: vc.view.bounds.size.width / 4).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(gradeField)
        gradeField.topAnchor.constraint(equalTo: teamIdField.bottomAnchor, constant: TeamInfoRegisterResources.Constraint.gradeFieldTopConstraint).isActive = true
        gradeField.leftAnchor.constraint(equalTo: teamIdField.leftAnchor).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(sportsKindField)
        sportsKindField.topAnchor.constraint(equalTo: gradeField.bottomAnchor, constant: TeamInfoRegisterResources.Constraint.sportsKindFieldTopConstraint).isActive = true
        sportsKindField.leftAnchor.constraint(equalTo: teamIdField.leftAnchor).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(nextBtn)
        nextBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        nextBtn.topAnchor.constraint(equalTo: sportsKindField.bottomAnchor, constant: vc.view.bounds.size.width / 2).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
    }
    
    func getPickerView(type: TeamInfoRegistPickerType, vc: UIViewController) -> UIPickerView {
        var pickerView = UIPickerView()
        switch type {
        case .grade: pickerView = GradePickerView()
        case .sports: pickerView = SportsKindPickerView()
        }
        pickerView.dataSource = vc as? UIPickerViewDataSource
        pickerView.delegate = vc as? UIPickerViewDelegate
        pickerView.backgroundColor = .white
        return pickerView
    }
    
    func setupToolBar(_ textField: UITextField, type: TeamInfoRegistPickerType, toolBar: UIToolbar, content: Array<String>, vc: UIViewController) {
        textField.inputView = getPickerView(type: type, vc: vc)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
}

class GradePickerView: UIPickerView {}
class SportsKindPickerView: UIPickerView {}
