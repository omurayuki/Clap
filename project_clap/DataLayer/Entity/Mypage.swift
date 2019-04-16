import Foundation

struct Mypage {
    var mail: String?
    var name: String?
    var role: String?
    var team: String?
    var teamId: String?
    var userId: String?
    
    init(document: [String: String]) {
        mail = document["mail"]
        name = document["name"]
        role = document["role"]
        team = document["team"]
        teamId = document["teamId"]
        userId = document["userId"]
    }
}
