import Foundation

protocol LoDiaryDetailDataStore {
    func getTeamId() -> String
}

struct LoDiaryDetailDataStoreImpl: LoDiaryDetailDataStore {
    func getTeamId() -> String {
        return AppUserDefaults.getValue(keyName: "teamId")
    }
}
