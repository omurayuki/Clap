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
            }).disposed(by: disposeBag)
        
        ui.submitBtn.rx.tap
            .bind { _ in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy年MM月dd日"
                let eventStartDateText = self.ui.startDate.text!
                let eventStartDate = formatter.date(from: eventStartDateText)
                let eventEndDateText = self.ui.endDate.text!
                let eventEndDate = formatter.date(from: eventEndDateText)
                guard let endDate = eventEndDate?.timeIntervalSince1970 else { return }
                guard let startDate = eventStartDate?.timeIntervalSince1970 else { return }
                let endDateIntType = Int(endDate)
                let startDateIntType = Int(startDate)
                let dateCount = (endDateIntType - startDateIntType) / (60 * 60 * 24)
                var array = [eventStartDateText]
                for date in 0..<dateCount {
                    let addingValue = date * (60 * 60 * 24)
                    let addedDateValue = startDateIntType + addingValue
                    let addedDateValueConvertToTimeInterval = TimeInterval(addedDateValue)
                    let addedDateValueConvertToDateType = Date(timeIntervalSince1970: addedDateValueConvertToTimeInterval)
                    let addedDateValueConvertToStringType: String = formatter.string(from: addedDateValueConvertToDateType)
                    array.append(addedDateValueConvertToStringType)
                }
            let setData = [
                "userId": UserSingleton.sharedInstance.uid,
                "startTime": self.ui.startTime.text ?? "",
                "endTime": self.ui.endTime.text ?? "",
                "title": self.ui.titleField.text ?? "",
                "content": self.ui.detailField.text ?? ""
                ] as [String : Any]
                let eventCollectionPath = RandomString.generateRandomString(length: 20)
                for i in 0 ..< array.count {
                    Firebase.db
                        .collection("calendar")
                        .document(AppUserDefaults.getValue(keyName: "teamId"))
                        .collection("dates")
                        .document(array[i])
                        .setData(["date": array[i]], completion: { error in
                            if let _ = error {
                                return
                            }
                            Firebase.db.collection("calendar")
                                .document(AppUserDefaults.getValue(keyName: "teamId"))
                                .collection("dates")
                                .document(array[i])
                                .collection("events")
                                .document(eventCollectionPath)
                                .setData(setData)
                        })
                    }
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
                self?.ui.endDate.text = self?.formatter.convertToMonthAndYears(self?.ui.endDatePicker.date)
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
        ui.endDate.text = isOn ? ui.endDate.text : ui.startDate.text
    }
    
    private func isOnInteractiveDate(_ isOn: Bool) {
        ui.startDate.isUserInteractionEnabled = isOn
        ui.endDate.isUserInteractionEnabled = isOn
    }
}
