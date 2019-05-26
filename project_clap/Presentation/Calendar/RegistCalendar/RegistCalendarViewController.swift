import Foundation
import UIKit
import RxSwift
import RxCocoa
import PopupDialog
import Result

class RegistCalendarViewController: UIViewController {
    
    private let recievedSelectedDate: Date?
    private var viewModel: RegistCalendarViewModel!
    
    private lazy var ui: RegistCalendarUI = {
        let ui = RegistCalendarUIImple()
        ui.startDate.text = ui.formatter.convertToMonthAndYears(recievedSelectedDate)
        ui.endDate.text = ui.formatter.convertToMonthAndYears(recievedSelectedDate)
        ui.startTime.text = ui.formatter.convertToTime(recievedSelectedDate)
        ui.endTime.text = ui.formatter.convertToTime(recievedSelectedDate)
        ui.viewController = self
        return ui
    }()
    
    init(selectedDate: Date, viewModel: RegistCalendarViewModel) {
        recievedSelectedDate = selectedDate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        setupDatePickerDate()
        setupViewModel()
    }
}

extension RegistCalendarViewController {
    
    private func setupDatePickerDate() {
        guard let date = recievedSelectedDate else { return }
        ui.startDatePicker.date = date
        ui.endDatePicker.date = date
        ui.startTimePicker.date = date
        ui.endTimePicker.date = date
    }
    
    private func setupViewModel() {
        ui.switchLongdayOrShortday.rx.isOn.asObservable()
            .subscribe(onNext: { event in
                if event {
                    self.isOnCalendarLabel(event, size: RegistCalendarResources.Font.largeDateFont)
                    self.isOnInteractiveDate(event)
                } else {
                    self.isOnCalendarLabel(event, size: RegistCalendarResources.Font.defaultDateFont)
                    self.isOnInteractiveDate(event)
                }
            }).disposed(by: viewModel.disposeBag)
        
        ui.submitBtn.rx.tap
            .flatMap { _ -> Single<Result<String, FirebaseError>> in
                let array = self.ui.formatter.generateBetweenDate(start: self.ui.startDate.text ?? "",
                                                               end: self.ui.endDate.text ?? "")
                return self.viewModel.registEvent(startToEnd: array, startDate: self.ui.startDate.text ?? "",
                                           endDate: self.ui.endDate.text ?? "", startTime: self.ui.startTime.text ?? "",
                                           endTime: self.ui.endTime.text ?? "", title: self.ui.titleField.text ?? "",
                                           content: self.ui.detailField.text ?? "")
            }.bind { response in
                switch response {
                case .failure(_):
                    AlertController.showAlertMessage(alertType: .logoutFailure, viewController: self)
                    return
                case .success:
                    return
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.cancelBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.ui.createCancelAlert(vc: this)
        }.disposed(by: viewModel.disposeBag)
        
        ui.startDatePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.ui.formatter.dateFormat = "yyyy年MM月dd日"
                self?.ui.startDate.text = self?.ui.formatter.convertToMonthAndYears(self?.ui.startDatePicker.date)
        }.disposed(by: viewModel.disposeBag)
        
        ui.endDatePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.ui.formatter.dateFormat = "yyyy年MM月dd日"
                self?.ui.endDate.text = self?.ui.formatter.convertToMonthAndYears(self?.ui.endDatePicker.date)
            }.disposed(by: viewModel.disposeBag)
        
        ui.startTimePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.ui.formatter.dateFormat = "hh:mm"
                self?.ui.startTime.text = self?.ui.formatter.convertToTime(self?.ui.startTimePicker.date)
            }.disposed(by: viewModel.disposeBag)
        
        ui.endTimePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.ui.formatter.dateFormat = "hh:mm"
                self?.ui.endTime.text = self?.ui.formatter.convertToTime(self?.ui.endTimePicker.date)
            }.disposed(by: viewModel.disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind{ [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: viewModel.disposeBag)
    }
    
    private func isOnCalendarLabel(_ isOn: Bool, size: UIFont) {
        ui.startTime.isHidden = isOn
        ui.endTime.isHidden = isOn
        ui.startDate.font = size
        ui.endDate.font = size
        ui.endDate.text = isOn ? ui.endDate.text : ui.startDate.text
    }
    
    private func isOnInteractiveDate(_ isOn: Bool) {
        ui.startDate.isUserInteractionEnabled = isOn
        ui.endDate.isUserInteractionEnabled = isOn
    }
}
