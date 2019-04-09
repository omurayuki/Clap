import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol LoginDataStore {
    func login(mail: String, pass: String, completion: ((String?, Error?) -> Void)?)
}

struct LoginDataStoreImpl: LoginDataStore {
    func login(mail: String, pass: String, completion: ((String?, Error?) -> Void)? = nil) {
        Firebase.fireAuth.signIn(withEmail: mail, password: pass, completion: { (response, error) in
            if let error = error {
                completion?(nil, error)
                return
            }
            //error handling
            guard let uid = Firebase.fireAuth.currentUser?.uid else { return }
            completion?(uid, nil)
        })
    }
}
