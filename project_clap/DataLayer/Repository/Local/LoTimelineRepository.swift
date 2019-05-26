import Foundation

protocol LoTimelineRepository {
    func fetchDiary() -> [String]
    func getTeamId() -> String
}

struct LoTimelineRepositoryImpl: LoTimelineRepository {
    
    let localStore: LoTimelineDataStore = LoTimelineDataStoreImpl()
    
    func fetchDiary() -> [String] {
        return localStore.fetchDiary()
    }
    
    func getTeamId() -> String {
        return localStore.getTeamId()
    }
}
