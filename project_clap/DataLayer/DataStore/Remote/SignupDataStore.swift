import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol SignupDataStore {
    func signup(email: String, pass: String, completion: ((String?) -> Void)?)
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String)
    func registUserWithTeam(teamId: String, uid: String)
    func saveUserData(user: String, teamId: String, name: String, role: String, mail: String, team: String, completion: (() -> Void)?)
    func fetchBelongData(teamId: String, completion: @escaping (String?) -> Void)
}

struct SignupDataStoreImpl: SignupDataStore {
    
    func signup(email: String, pass: String, completion: ((String?) -> Void)? = nil) {
        Firebase.fireAuth.createUser(withEmail: email, password: pass) { (response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response else { return }
            let user = User()
            user.uid = response.user.uid
            user.email = response.user.email ?? ""
            user.saveUserData(user: user)
            //error handling
            guard let uid = Firebase.fireAuth.currentUser?.uid else { return }
            completion?(uid)
        }
    }
    
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String) {
        let setData = ["belong": team, "grade": grade, "sportsKind": sportsKind]
        Firebase.db
            .collection("team")
            .document(teamId)
            .setData(setData)
    }
    
    func registUserWithTeam(teamId: String, uid: String) {
        let setData = ["regist": true, "teamId": teamId] as [String : Any]
        Firebase.db
            .collection("team")
            .document(teamId)
            .collection("users")
            .document(uid)
            .setData(setData)
    }
    
    func saveUserData(user: String, teamId: String, name: String, role: String, mail: String, team: String, completion: (() -> Void)? = nil) {
        let setData = ["teamId": teamId, "name": name, "role": role, "userId": user, "mail": mail, "team": team]
        Firebase.db
            .collection("users")
            .document(user)
            .setData(setData) { _ in
                completion?()
        }
    }
    
    func fetchBelongData(teamId: String, completion: @escaping (String?) -> Void) {
        Firebase.db.collection("team").document(teamId).getDocument(completion: { (response, error) in
            if let response = response, response.exists {
                let description = response.data()
                completion(description?["belong"] as? String ?? "")
            } else {
                print(error as Any)
            }
        })
    }
}
