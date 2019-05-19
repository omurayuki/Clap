import Foundation

class DiarySingleton: NSObject {
    var diaryId: String!, date: String!
    var text1: String!; var text2: String!
    var text3: String!; var text4: String!
    var text5: String!; var text6: String!
    
    class var sharedInstance: DiarySingleton {
        struct Static {
            static let instance: DiarySingleton = DiarySingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        diaryId = ""; date = ""
        text1 = ""; text2 = ""
        text3 = ""; text4 = ""
        text5 = ""; text6 = ""
    }
}
