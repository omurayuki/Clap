import Foundation
import RxSwift
import RxCocoa
import Result

protocol RegistCalendarViewModelInput {}

protocol RegistCalendarViewModelOutput {}

protocol RegistCalendarViewModelType {
    var inputs: RegistCalendarViewModelInput { get }
    var outputs: RegistCalendarViewModelOutput { get }
}

struct RegistCalendarViewModel: RegistCalendarViewModelType, RegistCalendarViewModelInput, RegistCalendarViewModelOutput {
    var inputs: RegistCalendarViewModelInput { return self }
    var outputs: RegistCalendarViewModelOutput { return self }
    let repository: CalendarRepository = CalendarRepositoryImpl()
    let disposeBag = DisposeBag()
    
    func registEvent(startToEnd: [String], startDate: String,
                     endDate: String, startTime: String,
                     endTime: String, title: String,
                     content: String) -> Single<Result<String, FirebaseError>> {
        return repository.registEvent(startToEnd: startToEnd, startDate: startDate,
                               endDate: endDate, startTime: startTime,
                               endTime: endTime, title: title, content: content)
    }
}
