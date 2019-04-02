import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol LoginRepository {
    static func login(mail: String, pass: String, vc: UIViewController, completion: (() -> Void)?)
}

struct LoginRepositoryImpl: LoginRepository {
    static func login(mail: String, pass: String, vc: UIViewController, completion: (() -> Void)? = nil) {
        Auth.auth().signIn(withEmail: mail, password: pass, completion: { (response, error) in
            if let _ = error {
                AlertController.showAlertMessage(alertType: .loginFailed, viewController: vc)
                return
            }
            completion?()
        })
    }
}
