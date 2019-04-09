import Foundation
import RxSwift
import RealmSwift

protocol SignupRepository {
    func signup(email: String, pass: String, completion: ((String?) -> Void)?)
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String)
    func registUserWithTeam(teamId: String, uid: String)
    func saveUserData(user: String, teamId: String, name: String, role: String, mail: String, team: String, completion: (() -> Void)?)
    func fetchBelongData(teamId: String, completion: @escaping (String?) -> Void)
}

struct SignupRepositoryImpl: SignupRepository {
    
    private let dataStore: SignupDataStore = SignupDataStoreImpl()
    
    func signup(email: String, pass: String, completion: ((String?) -> Void)? = nil) {
        dataStore.signup(email: email, pass: pass, completion: completion)
    }
    
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String) {
        dataStore.saveTeamData(teamId: teamId,
                               team: team,
                               grade: grade,
                               sportsKind: sportsKind)
    }
    
    func registUserWithTeam(teamId: String, uid: String) {
        dataStore.registUserWithTeam(teamId: teamId, uid: uid)
    }
    
    func saveUserData(user: String, teamId: String, name: String, role: String, mail: String, team: String, completion: (() -> Void)? = nil) {
        dataStore.saveUserData(user: user, teamId: teamId,
                               name: name, role: role,
                               mail: mail, team: team,
                               completion: completion)
    }
    
    func fetchBelongData(teamId: String, completion: @escaping (String?) -> Void) {
        dataStore.fetchBelongData(teamId: teamId, completion: completion)
    }
}
