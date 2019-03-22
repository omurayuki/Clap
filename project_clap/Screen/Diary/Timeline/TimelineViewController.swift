import Foundation
import UIKit
import RxSwift
import RxCocoa

class TimelineViewController: UIViewController {
    
    private var viewModel: TimeLineViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var ui: TimeLineUI = {
        let ui = TimeLineUIImpl()
        ui.viewController = self
        ui.diariesTable.dataSource = self
        ui.diariesTable.delegate = self
        return ui
    }()
    
    private lazy var routing: TimeLineRouting = {
        let routing = TimeLineRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        viewModel = TimeLineViewModel()
        ui.setupToolBar(ui.timeLineField, toolBar: ui.timeLineToolBar, content: viewModel?.outputs.timeLineArr ?? [R.string.locarizable.empty()], vc: self)
        setupViewModel()
    }
}

extension TimelineViewController {
    
    private func setupViewModel() {
        ui.diaryBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.ui.diaryBtn.bounce(completion: {
                    self?.routing.showDiaryRegist()
                })
            }).disposed(by: disposeBag)
        
        ui.doneBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                if let _ = self?.ui.timeLineField.isFirstResponder {
                    self?.ui.timeLineField.resignFirstResponder()
                }
            }.disposed(by: disposeBag)
        
        ui.timeLineField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                self?.ui.timeLineField.resignFirstResponder()
            }.disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ui.configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TimeLineResources.View.tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ui.configureHeaderView(tableView: tableView, section: section)
    }
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        ui.timeLineField.text = viewModel?.outputs.timeLineArr[row] ?? R.string.locarizable.empty()
    }
}
