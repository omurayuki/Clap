import UIKit

struct ReplyCellResources {
    
    struct Constraint {
        static let userImageTopConstraint: CGFloat = 20
        static let userImageLeftConstraint: CGFloat = 20
        static let userImageWidthConstraint: CGFloat = 40
        static let userImageHeightConstraint: CGFloat = 40
        static let nameTopConstraint: CGFloat = 20
        static let nameLeftConstraint: CGFloat = 20
        static let timeTopConstraint: CGFloat = 20
        static let replyTopConstraint: CGFloat = 20
        static let replyLeftConstraint: CGFloat = 20
        static let replyRightConstraint: CGFloat = -20
        static let replyBottomConstraint: CGFloat = -20
        static let replyWriteFieldTopConstraint: CGFloat = 10
        static let replyWriteFieldLeftConstraint: CGFloat = 15
        static let replyWriteFieldRightConstraint: CGFloat = -15
        static let replyWriteFieldHeightConstraint: CGFloat = 35
        static let replyTableTopConstraint: CGFloat = 20
    }
    
    struct View {
        static let tableRowHeight: CGFloat = 100
        static let estimatedRowHeight: CGFloat = 200
        static let userImageLayerCornerRadius: CGFloat = 20
        static let replyNumberOfLines = 0
    }
    
    struct Font {
        static let nameFont = UIFont.systemFont(ofSize: 12)
        static let dateFont = UIFont.systemFont(ofSize: 12)
        static let commentFont = UIFont.systemFont(ofSize: 12)
        static let replyFont = UIFont.systemFont(ofSize: 12)
    }
}
