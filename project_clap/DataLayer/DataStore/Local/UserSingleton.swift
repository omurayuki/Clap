import Foundation

//userがログインした際に、保存 userデータを取得するため
class UserSingleton: NSObject {
    var uid: String!
    var name: String!
    var image: String!
    
    class var sharedInstance: UserSingleton {
        struct Static {
            static let instance: UserSingleton = UserSingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        uid = ""
        name = ""
        image = ""
    }
}
