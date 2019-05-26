import Foundation
import UIKit

protocol TeamInfoRegistUI: UI {
    var noticeTeamInfoRegistTitle: UILabel { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var teamNameField: CustomTextField { get set }
    var gradeField: CustomTextField { get }
    var sportsKindField: CustomTextField { get }
    var nextBtn: UIButton { get }
    var gradeToolBar: UIToolbar { get }
    var gradeDoneBtn: UIBarButtonItem { get }
    var sportsKindToolBar: UIToolbar { get }
    var sportsKindDoneBtn: UIBarButtonItem { get }
    
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
        return label
    }()
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    var teamNameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.place_holder_team_id()
        field.clearButtonMode = .always
        return field
    }()
    
    private(set) var gradeField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        return field
    }()
    
    private(set) var sportsKindField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.select()
        field.tintColor = .clear
        return field
    }()
    
    private(set) var nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.next(), for: .normal)
        button.alpha = 0.2
        button.isUserInteractionEnabled = false
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TeamInfoRegisterResources.View.nextBtnCornerRadius
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
    
    private(set) var gradeDoneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
    
    private(set) var sportsKindToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private(set) var sportsKindDoneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
}

extension TeamInfoRegistUIImpl {
    func setup(storeName: String) {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.navigationItem.title = storeName
        [noticeTeamInfoRegistTitle, teamNameField, gradeField, sportsKindField, nextBtn].forEach { vc.view.addSubview($0) }
        vc.view.addGestureRecognizer(viewTapGesture)
        gradeToolBar.items = [gradeDoneBtn]
        sportsKindToolBar.items = [sportsKindDoneBtn]
        
        noticeTeamInfoRegistTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        teamNameField.anchor()
            .centerXToSuperview()
            .top(to: noticeTeamInfoRegistTitle.bottomAnchor, constant: vc.view.bounds.size.width / 4)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        gradeField.anchor()
            .top(to: teamNameField.bottomAnchor, constant: TeamInfoRegisterResources.Constraint.gradeFieldTopConstraint)
            .left(to: teamNameField.leftAnchor)
            .activate()
        
        sportsKindField.anchor()
            .top(to: gradeField.bottomAnchor, constant: TeamInfoRegisterResources.Constraint.sportsKindFieldTopConstraint)
            .left(to: teamNameField.leftAnchor)
            .activate()
        
        nextBtn.anchor()
            .centerXToSuperview()
            .top(to: sportsKindField.bottomAnchor, constant: vc.view.bounds.size.width / 2)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
    
    #warning("共通化処理できる")
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
    
    func setupToolBar(_ textField: UITextField,
                      type: TeamInfoRegistPickerType,
                      toolBar: UIToolbar,
                      content: Array<String>,
                      vc: UIViewController) {
        textField.inputView = getPickerView(type: type, vc: vc)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
}

class GradePickerView: UIPickerView {}
class SportsKindPickerView: UIPickerView {}
