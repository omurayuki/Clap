import Foundation
import RxSwift

protocol LoTimelineDataStore {
    func fetchDiary() -> [String]
    func getTeamId() -> String
}

struct LoTimelineDataStoreImpl: LoTimelineDataStore {
    func fetchDiary() -> [String] {
        return [DiarySingleton.sharedInstance.text1, DiarySingleton.sharedInstance.text2,
                DiarySingleton.sharedInstance.text3, DiarySingleton.sharedInstance.text4,
                DiarySingleton.sharedInstance.text5, DiarySingleton.sharedInstance.text6]
    }
    
    func getTeamId() -> String {
        return AppUserDefaults.getValue(keyName: "teamId")
    }
}
