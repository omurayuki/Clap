import Foundation
import UIKit
import RxSwift
import RxCocoa
import PopupDialog

class RegistCalendarViewController: UIViewController {
    
    private let recievedSelectedDate: Date?
    private let disposeBag = DisposeBag()
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
    
    private lazy var ui: RegistCalendarUI = {
        let ui = RegistCalendarUIImple()
        ui.startDate.text = formatter.convertToMonthAndYears(recievedSelectedDate)
        ui.endDate.text = formatter.convertToMonthAndYears(recievedSelectedDate)
        ui.startTime.text = formatter.convertToTime(recievedSelectedDate)
        ui.endTime.text = formatter.convertToTime(recievedSelectedDate)
        ui.viewController = self
        return ui
    }()
    
    init(selectedDate: Date) {
        recievedSelectedDate = selectedDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                } else {
                    self.isOnCalendarLabel(event, size: RegistCalendarResources.Font.defaultDateFont)
                }
            }).disposed(by: disposeBag)
        
        ui.eventAddBtn.rx.tap
            .bind { _ in
                //DBに保存+ローカルDBに保存
        }.disposed(by: disposeBag)
        
        ui.cancelBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.ui.createCancelAlert(vc: this)
        }.disposed(by: disposeBag)
        
        ui.startDatePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.formatter.dateFormat = "yyyy年MM月dd日"
                self?.ui.startDate.text = self?.formatter.convertToMonthAndYears(self?.ui.startDatePicker.date)
        }.disposed(by: disposeBag)
        
        ui.endDatePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.formatter.dateFormat = "yyyy年MM月dd日"
                self?.ui.endDate.text = self?.formatter.convertToMonthAndYears(self?.ui.startDatePicker.date)
            }.disposed(by: disposeBag)
        
        ui.startTimePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.formatter.dateFormat = "hh:mm"
                self?.ui.startTime.text = self?.formatter.convertToTime(self?.ui.startTimePicker.date)
            }.disposed(by: disposeBag)
        
        ui.endTimePicker.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                self?.formatter.dateFormat = "hh:mm"
                self?.ui.endTime.text = self?.formatter.convertToTime(self?.ui.endTimePicker.date)
            }.disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind{ [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
    
    private func isOnCalendarLabel(_ isOn: Bool, size: UIFont) {
        ui.startTime.isHidden = isOn
        ui.endTime.isHidden = isOn
        ui.startDate.font = size
        ui.endDate.font = size
    }
}
