import Foundation
import RxSwift
import RxCocoa

protocol TimelineRepository {
    func fetchDiaries() -> Single<[TimelineCellData]>
    func fetchIndividualDiaries(submit: Bool, uid: String) -> Single<[TimelineCellData]>
}

struct TimelineRepositoryImpl: TimelineRepository {
    
    private let dataStore: TimelineDataStore = TimelineDataStoreImpl()
    
    func fetchDiaries() -> Single<[TimelineCellData]> {
        return dataStore.fetchDiaries()
    }
    
    func fetchIndividualDiaries(submit: Bool, uid: String) -> Single<[TimelineCellData]> {
        return dataStore.fetchIndividualDiaries(submit: submit, uid: uid)
    }
}
