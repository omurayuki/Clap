import Foundation
import UIKit

protocol TimeLineUI: UI {
    var diariesTable: UITableView { get }
    var doneBtn: UIBarButtonItem { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var timeLineToolBar: UIToolbar { get }
    var timeLineField: UITextField { get }
    var diaryBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func getPickerView(vc: UIViewController) -> UIPickerView
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController)
}

final class TimeLineUIImpl: TimeLineUI {
    
    weak var viewController: UIViewController?
    
    private(set) var diariesTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = AppResources.ColorResources.appCommonClearColor
        table.rowHeight = TimeLineResources.View.tableRowHeight
        table.register(TimeLineCell.self, forCellReuseIdentifier: String(describing: TimeLineCell.self))
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private(set) var timeLineToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private(set) var doneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    private(set) var timeLineField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.tintColor = .clear
        field.backgroundColor = .white
        field.layer.cornerRadius = TimeLineResources.View.timeLineFieldLayerCornerRadius
        field.layer.borderWidth = TimeLineResources.View.timeLineFieldBorderWidth
        field.layer.borderColor = UIColor.gray.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var diaryBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = TimeLineResources.Font.diaryBtnFont
        button.layer.cornerRadius = TimeLineResources.View.diaryBtnLayerCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension TimeLineUIImpl {
    
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.diary_title()
        vc.view.addSubview(diariesTable)
        diariesTable.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor).isActive = true
        diariesTable.leftAnchor.constraint(equalTo: vc.view.leftAnchor).isActive = true
        diariesTable.rightAnchor.constraint(equalTo: vc.view.rightAnchor).isActive = true
        diariesTable.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        vc.view.addSubview(diaryBtn)
        diaryBtn.bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: TimeLineResources.Constraint.diaryBtnBottomConstraint).isActive = true
        diaryBtn.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: TimeLineResources.Constraint.diaryBtnRightConstrain).isActive = true
        diaryBtn.widthAnchor.constraint(equalToConstant: TimeLineResources.Constraint.diaryBtnWidthConstraint).isActive = true
        diaryBtn.heightAnchor.constraint(equalToConstant: TimeLineResources.Constraint.diaryBtnHeightConstraint).isActive = true
        
        timeLineToolBar.items = [doneBtn]
        vc.view.addGestureRecognizer(viewTapGesture)
    }
    
    func getPickerView(vc: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = vc as? UIPickerViewDataSource
        pickerView.delegate = vc as? UIPickerViewDelegate
        pickerView.backgroundColor = .white
        return pickerView
    }
    
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController) {
        textField.inputView = getPickerView(vc: vc)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
}
