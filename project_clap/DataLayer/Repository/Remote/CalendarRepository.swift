import Foundation
import RxSwift
import Result

protocol CalendarRepository {
    func registEvent(startToEnd: [String], startDate: String,
                     endDate: String, startTime: String,
                     endTime: String, title: String,
                     content: String) -> Single<Result<String, FirebaseError>>
    func loadEvent() -> Observable<Result<[String: [String]], FirebaseError>>
}

struct CalendarRepositoryImpl: CalendarRepository {
    
    let dataStore: CalendarDataStore = CalendarDataStoreImpl()
    
    func registEvent(startToEnd: [String], startDate: String,
                     endDate: String, startTime: String,
                     endTime: String, title: String,
                     content: String) -> Single<Result<String, FirebaseError>> {
        return dataStore.registEvent(startToEnd: startToEnd, startDate: startDate,
                                     endDate: endDate, startTime: startTime,
                                     endTime: endTime, title: title, content: content)
    }
    
    func loadEvent() -> Observable<Result<[String: [String]], FirebaseError>> {
        return dataStore.loadEvent()
    }
}
