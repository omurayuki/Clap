import Foundation

protocol LoDiaryDetailRepository {
    func getTeamId() -> String
}

struct LoDiaryDetailRepositoryImpl: LoDiaryDetailRepository {
    
    let localStore: LoDiaryDetailDataStore = LoDiaryDetailDataStoreImpl()
    func getTeamId() -> String {
        return localStore.getTeamId()
    }
}
