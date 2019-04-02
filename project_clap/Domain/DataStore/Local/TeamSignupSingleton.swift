import UIKit

class TeamSignupSingleton: NSObject {
    var team: String!
    var grade: String!
    var sportsKind: String!
    var name: String!
    var mail: String!
    var representMemberPosition: String!
    var representMemberYear: String!
    
    class var sharedInstance: TeamSignupSingleton {
        struct Static {
            static let instance: TeamSignupSingleton = TeamSignupSingleton()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
        team = "";                  grade = ""
        sportsKind = "";            name = ""
        mail = "";                  representMemberPosition = ""
        representMemberYear = ""
    }
}
