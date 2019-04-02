import Foundation
import RealmSwift

class User: Object {
    static let realm = try! Realm()
    
    @objc dynamic var uid: String = ""
    @objc dynamic var email: String = ""
    
    func saveUserData(user: User) {
        do {
            try? User.realm.write {
                User.realm.add(user)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
