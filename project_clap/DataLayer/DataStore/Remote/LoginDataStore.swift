import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol LoginDataStore {
    func login(mail: String, pass: String) -> Single<String>
}

struct LoginDataStoreImpl: LoginDataStore {
    func login(mail: String, pass: String) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.fireAuth.signIn(withEmail: mail, password: pass, completion: { (response, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let uid = response?.user.uid else { return }
                single(.success(uid))
            })
            return Disposables.create()
        })
    }
}
