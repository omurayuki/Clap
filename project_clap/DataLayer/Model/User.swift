import Foundation
import RealmSwift
import Result

class User: Object {
    static let realm = try? Realm()
    
    @objc dynamic var uid: String = ""
    @objc dynamic var email: String = ""
    
    func saveUserData(user: User, completion: ((Error?) -> Void)?) {
        do {
            try? User.realm?.write {
                User.realm?.add(user)
                completion?(nil)
            }
        } catch let error {
            completion?(error)
        }
    }
}
