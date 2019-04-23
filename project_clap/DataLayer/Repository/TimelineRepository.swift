import Foundation
import RxSwift
import RxCocoa

protocol TimelineRepository {
    func fetchDiaries() -> Single<[TimelineCellData]>
}

class TimelineRepositoryImpl: TimelineRepository {
    func fetchDiaries() -> Single<[TimelineCellData]> {
        return TimelineDataStoreImpl().fetchDiaries()
    }
}
