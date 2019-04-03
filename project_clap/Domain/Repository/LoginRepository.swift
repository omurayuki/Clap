import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol LoginRepository {
    static func login(mail: String, pass: String, completion: ((Error?) -> Void)?)
}

struct LoginRepositoryImpl: LoginRepository {
    static func login(mail: String, pass: String, completion: ((Error?) -> Void)? = nil) {
        Firebase.fireAuth.signIn(withEmail: mail, password: pass, completion: { (response, error) in
            if let error = error {
                completion?(error)
                return
            }
            completion?(nil)
        })
    }
}
