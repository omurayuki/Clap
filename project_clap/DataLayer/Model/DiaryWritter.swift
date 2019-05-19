import Foundation
import RealmSwift

class Player: Object {
    static let realm = try? Realm()
    
    @objc dynamic var teamId: String = ""
    @objc dynamic var userId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var team: String = ""
    @objc dynamic var representMemberPosition: String = ""
    @objc dynamic var email: String = ""
}
