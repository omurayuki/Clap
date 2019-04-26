import Foundation

class CommentSingleton: NSObject {
    var commentId: [String]!; var userId: [String]!
    var image: [String]!; var name: [String]!
    var time: [String]!; var comment: [String]!
    
    class var sharedInstance: CommentSingleton {
        struct Static {
            static let instance: CommentSingleton = CommentSingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        commentId = [String](); userId = [String]()
        image = [String](); name = [String]()
        time = [String](); comment = [String]()
    }
}
