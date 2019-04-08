import Foundation

//userがログインした際に、保存 userデータを取得するため
class UIDSingleton: NSObject {
    var uid: String!
    
    class var sharedInstance: UIDSingleton {
        struct Static {
            static let instance: UIDSingleton = UIDSingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        uid = ""
    }
}
