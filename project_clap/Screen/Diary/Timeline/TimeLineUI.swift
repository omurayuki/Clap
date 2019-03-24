import Foundation
import UIKit

protocol TimeLineUI: UI {
    var diariesTable: UITableView { get }
    var doneBtn: UIBarButtonItem { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var timeLineToolBar: UIToolbar { get }
    var timeLineField: UITextField { get }
    var timeLineSegment: UISegmentedControl { get }
    var diaryBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func getPickerView(vc: UIViewController) -> UIPickerView
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController)
    func configureCell(tableView: UITableView, indexPath: IndexPath, content: [TimeLineDataType]) -> UITableViewCell
    func configureHeaderView(tableView: UITableView, section: Int, vc: UIViewController) -> UIView?
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
    
    private(set) var timeLineSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["タイムライン", "提出済", "下書き"])
        sc.selectedSegmentIndex = 0
        return sc
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
        timeLineToolBar.items = [doneBtn]
        vc.view.addGestureRecognizer(viewTapGesture)
        vc.view.addSubview(diariesTable)
        vc.view.addSubview(diaryBtn)
        diariesTable.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .left(to: vc.view.leftAnchor)
            .right(to: vc.view.rightAnchor)
            .bottom(to: vc.view.bottomAnchor)
            .activate()
        
        diaryBtn.anchor()
            .bottom(to: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: TimeLineResources.Constraint.diaryBtnBottomConstraint)
            .right(to: vc.view.rightAnchor, constant: TimeLineResources.Constraint.diaryBtnRightConstrain)
            .width(constant: TimeLineResources.Constraint.diaryBtnWidthConstraint)
            .height(constant: TimeLineResources.Constraint.diaryBtnHeightConstraint)
            .activate()
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
    
    func configureCell(tableView: UITableView, indexPath: IndexPath, content: [TimeLineDataType]) -> UITableViewCell {
        let data = content[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimeLineCell.self), for: indexPath) as? TimeLineCell else { return UITableViewCell() }
        cell.configureInit(image: nil, name: data.name, title: data.title, time: data.submittedDate)
        return cell
    }
    
    func configureHeaderView(tableView: UITableView, section: Int, vc: UIViewController) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: TimeLineResources.View.tableHeaderHeight))
        headerView.backgroundColor = AppResources.ColorResources.appCommonClearColor
        headerView.addSubview(timeLineSegment)
        timeLineSegment.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(constant: vc.view.frame.size.width - 10 * 2)
            .activate()
        
        return headerView
    }
}
