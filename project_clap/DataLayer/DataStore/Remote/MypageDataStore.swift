import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol MypageDataStore {
    func fetchMypageData(uid: String) -> Single<Mypage>
    func updateMypageData(uid: String, updateData: [String: Any], updateTeam: [String: Any]) -> Single<String>
    func updateEmail(email: String)
}

class MypageDataStoreImpl: MypageDataStore {
    func fetchMypageData(uid: String) -> Single<Mypage> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("users")
                .document(uid)
                .getDocument(completion: { (response, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let document = response, document.exists else { return }
                guard let documentData = document.data() as? [String : String] else { return }
                let model = Mypage(document: documentData)
                single(.success(model))
            })
            return Disposables.create()
        })
    }
    
    func updateMypageData(uid: String, updateData: [String: Any], updateTeam: [String: Any]) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("users")
                .document(uid)
                .updateData(updateData, completion: { error in
                    if let _ = error { return }
                    Firebase.db
                        .collection("team")
                        .document(AppUserDefaults.getValue(keyName: "teamId"))
                        .updateData(updateTeam, completion: { error in
                            if let error = error {
                                single(.error(error))
                                return
                            }
                            single(.success("successful"))
                        })
            })
            return Disposables.create()
        })
    }
    
    func updateEmail(email: String) {
        Firebase.fireAuth.currentUser?.updateEmail(to: email, completion: { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        })
    }
}
