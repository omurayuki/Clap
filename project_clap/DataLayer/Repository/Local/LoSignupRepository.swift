import Foundation
import Realm
import RealmSwift

protocol LoSignupRepository {
    func saveToTeamSingleton(team: String, grade: String, sportsKind: String)
    func saveToTeamSingleton(name: String,
                         mail: String,
                         representMemberPosition: String,
                         representMemberYear: String)
    func getUserData() -> Results<User>?
    func saveUserData(uid: String, email: String, completion: @escaping (Error?) -> Void)
}

struct LoSignupRepositoryImpl: LoSignupRepository {
    
    let localStore: LoSignupDataStore = LoSignupDataStoreImpl()
    
    func saveToTeamSingleton(team: String, grade: String, sportsKind: String) {
        localStore.saveToTeamSingleton(team: team, grade: grade, sportsKind: sportsKind)
    }
    
    func saveToTeamSingleton(name: String,
                         mail: String,
                         representMemberPosition: String,
                         representMemberYear: String) {
        localStore.saveToTeamSingleton(name: name,
                                       mail: mail,
                                       representMemberPosition: representMemberPosition,
                                       representMemberYear: representMemberYear)
    }
    
    func getUserData() -> Results<User>? {
        return localStore.getUserData()
    }
    
    func saveUserData(uid: String, email: String, completion: @escaping (Error?) -> Void) {
        localStore.saveUserData(uid: uid, email: email, completion: completion)
    }
}
