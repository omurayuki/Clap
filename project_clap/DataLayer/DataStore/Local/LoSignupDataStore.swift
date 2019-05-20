import Foundation
import Realm
import RealmSwift

protocol LoSignupDataStore {
    func saveToTeamSingleton(team: String, grade: String, sportsKind: String)
    func saveToTeamSingleton(name: String,
                         mail: String,
                         representMemberPosition: String,
                         representMemberYear: String)
    func saveToSingleton(name: String,
                         mail: String,
                         representMemberPosition: String)
    func getUserData() -> Results<User>?
    func saveUserData(uid: String, email: String, completion: @escaping (Error?) -> Void)
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
    
    func saveToSingleton(name: String,
                         mail: String,
                         representMemberPosition: String) {
        TeamSignupSingleton.sharedInstance.name = name
        TeamSignupSingleton.sharedInstance.mail = mail
        TeamSignupSingleton.sharedInstance.representMemberPosition = representMemberPosition
    }
    
    func getUserData() -> Results<User>? {
        let realm = try? Realm()
        let results = realm?.objects(User.self)
        return results
    }
    
    func saveUserData(uid: String, email: String, completion: @escaping (Error?) -> Void) {
        let user = User()
        user.uid = uid
        user.email = email
        user.saveUserData(user: user, completion: completion)
    }
}
