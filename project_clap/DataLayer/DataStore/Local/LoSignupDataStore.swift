import Foundation
import Realm
import RealmSwift

protocol LoSignupDataStore {
    func saveToTeamSingleton(team: String, grade: String, sportsKind: String)
    func saveToTeamSingleton(name: String,
                         mail: String,
                         representMemberPosition: String,
                         representMemberYear: String)
    func getUserData() -> Results<User>?
}

struct LoSignupDataStoreImpl: LoSignupDataStore {
    func saveToTeamSingleton(team: String, grade: String, sportsKind: String) {
        TeamSignupSingleton.sharedInstance.team = team
        TeamSignupSingleton.sharedInstance.grade = grade
        TeamSignupSingleton.sharedInstance.sportsKind = sportsKind
    }
    
    func saveToTeamSingleton(name: String,
                         mail: String,
                         representMemberPosition: String,
                         representMemberYear: String) {
        TeamSignupSingleton.sharedInstance.name = name
        TeamSignupSingleton.sharedInstance.mail = mail
        TeamSignupSingleton.sharedInstance.representMemberPosition = representMemberPosition
        TeamSignupSingleton.sharedInstance.representMemberYear = representMemberYear
    }
    
    func getUserData() -> Results<User>? {
        let realm = try? Realm()
        let results = realm?.objects(User.self)
        return results
    }
}
