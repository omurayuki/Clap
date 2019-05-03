import Foundation

class ReplySingleton: NSObject {
    var replyId: [String]!; var userId: [String]!
    var image: [String]!; var name: [String]!
    var time: [String]!; var reply: [String]!
    
    class var sharedInstance: ReplySingleton {
        struct Static {
            static let instance: ReplySingleton = ReplySingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        replyId = [String](); userId = [String]()
        image = [String](); name = [String]()
        time = [String](); reply = [String]()
    }
}
