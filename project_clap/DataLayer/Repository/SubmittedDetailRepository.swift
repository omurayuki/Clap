import Foundation
import RxSwift
import RxCocoa

protocol SubmittedDetailRepository {
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]>
}

struct SubmittedDetailRepositoryImpl: SubmittedDetailRepository {
    
    private let dataStore: SubmittedDetailDataStore = SubmittedDetailDataStoreImpl()
    
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]> {
        return dataStore.fetchDiaryDetail(teamId: teamId, diaryId: diaryId)
    }
}
