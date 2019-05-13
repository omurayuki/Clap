import Foundation

enum Segment {
    enum Timeline: Int {
        case timeline = 0
        case submitted
        case draft
    }
    
    enum Mypage:Int {
        case submitted = 0
        case draft
    }
}
