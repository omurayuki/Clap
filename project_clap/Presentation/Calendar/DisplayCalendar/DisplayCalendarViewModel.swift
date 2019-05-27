import Foundation
import RxSwift
import Result

protocol DisplayCalendarViewModelInput {}

protocol DisplayCalendarViewModelOutput {}

protocol DisplayCalendarViewModelType {
    var inputs: DisplayCalendarViewModelInput { get }
    var outputs: DisplayCalendarViewModelOutput { get }
}

struct DisplayCalendarViewModel: DisplayCalendarViewModelType, DisplayCalendarViewModelInput, DisplayCalendarViewModelOutput {
    var inputs: DisplayCalendarViewModelInput { return self }
    var outputs: DisplayCalendarViewModelOutput { return self }
    let repository: CalendarRepository = CalendarRepositoryImpl()
    let disposeBag = DisposeBag()
    
    func loadEvent() -> Observable<Result<[String: [String]], FirebaseError>> {
        return repository.loadEvent()
    }
}
