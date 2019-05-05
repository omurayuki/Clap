import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol SignupDataStore {
    func signup(email: String, pass: String, completion: ((String?) -> Void)?) -> Single<AuthDataResult>
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String) -> Single<String>
    func registUserWithTeam(teamId: String, uid: String) -> Single<String>
    func saveUserData(user: String, teamId: String,
                      name: String, role: String,
                      mail: String, team: String) -> Single<String>
    func fetchBelongData(teamId: String) -> Single<String>
    func fetchBelongData(teamId: String, completion: @escaping (String?) -> Void)
}

struct SignupDataStoreImpl: SignupDataStore {
    
    func signup(email: String, pass: String, completion: ((String?) -> Void)?) -> Single<AuthDataResult> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.fireAuth.createUser(withEmail: email, password: pass) { (response, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let response = response else { return }
                single(.success(response))
                guard let uid = Firebase.fireAuth.currentUser?.uid else { return }
                completion?(uid)
            }
            return Disposables.create()
        })
    }
    
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String) -> Single<String> {
        let setData = ["belong": team, "grade": grade, "sportsKind": sportsKind]
        return Single<String>.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("team")
                .document(teamId)
                .setData(setData) { error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    single(.success("successful"))
            }
            return Disposables.create()
        })
    }
    
    func registUserWithTeam(teamId: String, uid: String) -> Single<String> {
        let setData = ["regist": true, "teamId": teamId] as [String : Any]
        return Single<String>.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("team")
                .document(teamId)
                .collection("users")
                .document(uid)
                .setData(setData) { error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    single(.success("successful"))
            }
            return Disposables.create()
        })
    }
    
    func saveUserData(user: String, teamId: String,
                      name: String, role: String,
                      mail: String, team: String) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            let setData = ["teamId": teamId, "name": name, "role": role, "userId": user, "mail": mail, "team": team]
            Firebase.db
                .collection("users")
                .document(user)
                .setData(setData) { error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                single(.success("successful"))
            }
            return Disposables.create()
        })
    }
    
    func fetchBelongData(teamId: String) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db.collection("team").document(teamId).getDocument(completion: { (response, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                if let response = response, response.exists {
                    let description = response.data()
                    single(.success(description?["belong"] as? String ?? ""))
                }
            })
            return Disposables.create()
        })
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
