import Foundation
import UIKit
import RxSwift
import RxCocoa

class TimelineViewController: UIViewController {
    
    private var viewModel: TimeLineViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var diariesTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = AppResources.ColorResources.appCommonClearColor
        table.rowHeight = TimeLineResources.View.tableRowHeight
        table.register(TimeLineCell.self, forCellReuseIdentifier: String(describing: TimeLineCell.self))
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var timeLineToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: TeamInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedTimeLineToolBar(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace, doneButton]
        accessoryToolbar.barTintColor = .white
        return accessoryToolbar
    }()
    
    private lazy var timeLineField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.tintColor = .clear
        field.backgroundColor = .white
        field.layer.cornerRadius = TimeLineResources.View.timeLineFieldLayerCornerRadius
        field.layer.borderWidth = TimeLineResources.View.timeLineFieldBorderWidth
        field.layer.borderColor = UIColor.gray.cgColor
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var diaryBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = TimeLineResources.Font.diaryBtnFont
        button.layer.cornerRadius = TimeLineResources.View.diaryBtnLayerCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TimeLineViewModel()
        setupToolBar(timeLineField, toolBar: timeLineToolBar, content: viewModel?.outputs.timeLineArr ?? [R.string.locarizable.empty()])
        setupUI()
        setupViewModel()
    }
}

extension TimelineViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.diary_title()
        view.addSubview(diariesTable)
        diariesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        diariesTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        diariesTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        diariesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.addSubview(diaryBtn)
        diaryBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: TimeLineResources.Constraint.diaryBtnBottomConstraint).isActive = true
        diaryBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: TimeLineResources.Constraint.diaryBtnRightConstrain).isActive = true
        diaryBtn.widthAnchor.constraint(equalToConstant: TimeLineResources.Constraint.diaryBtnWidthConstraint).isActive = true
        diaryBtn.heightAnchor.constraint(equalToConstant: TimeLineResources.Constraint.diaryBtnHeightConstraint).isActive = true
    }
    
    private func setupViewModel() {
        diaryBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.diaryBtn.bounce(completion: {
                    guard let `self` = self?.navigationController else { return }
                    `self`.present(DiaryRegistViewController(), animated: true)
                })
            }).disposed(by: disposeBag)
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
    
    @objc
    private func tappedTimeLineToolBar(sender: UIToolbar) {
        if timeLineField.isFirstResponder {
            timeLineField.resignFirstResponder()
        }
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimeLineCell.self), for: indexPath) as? TimeLineCell else { return UITableViewCell() }
        cell.configureInit(image: UIImage(), name: "omura", title: "heyheyheyhey", time: "10:00")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TimeLineResources.View.tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: TimeLineResources.View.tableHeaderHeight))
        headerView.backgroundColor = AppResources.ColorResources.appCommonClearColor
        headerView.addSubview(timeLineField)
        timeLineField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        timeLineField.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        timeLineField.widthAnchor.constraint(equalToConstant: TimeLineResources.Constraint.timeLineFieldWidthConstraint).isActive = true
        return headerView
    }
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TimelineViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension TimelineViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return TimeLineResources.View.pickerNumberOfComponents
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.outputs.timeLineArr.count ?? 0
    }
}

extension TimelineViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.outputs.timeLineArr[row] ?? R.string.locarizable.empty()
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeLineField.text = viewModel?.outputs.timeLineArr[row] ?? R.string.locarizable.empty()
    }
}
