import Foundation

class TimelineSingleton: NSObject {
    
    var sections: [TableSection<Date, TimelineCellData>]!
    
    class var sharedInstance: TimelineSingleton {
        struct Static {
            static let instance: TimelineSingleton = TimelineSingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        sections = [TableSection<Date, TimelineCellData>]()
    }
}
