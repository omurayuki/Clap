import Foundation
import RealmSwift

//remoteからfetchする用のフォルダ
//remoteの~~のデータを取得するとか
//ログインしたときに、fetchしてきて保存
//非同期的に保存
//取得したデータをmainthhreadで保存

class Player: Object {
    static let realm = try! Realm()
    
    @objc dynamic var teamId: String!
    @objc dynamic var userId: String!
    @objc dynamic var name: String!
    @objc dynamic var team: String!
    @objc dynamic var representMemberPosition: String!
    @objc dynamic var email: String!
}
