import Foundation
import UIKit

struct CommentCellResources {
    struct Constraint {
        static let userImageLeftConstraint: CGFloat = 20
        static let userImageRightConstraint: CGFloat = 20
        static let userImageWidthConstraint: CGFloat = 40
        static let userImageHeightConstraint: CGFloat = 40
        static let nameTopConstraint: CGFloat = 20
        static let nameLeftConstraint: CGFloat = 20
        static let dateTopConstraint: CGFloat = 20
        static let commentTopConstraint: CGFloat = 20
        static let commentLeftConstraint: CGFloat = 20
        static let commentBottomConstraint: CGFloat = -20
        static let replyCountBtnTopConstraint: CGFloat = 20
        static let replyCountBtnLeftConstraint: CGFloat = 20
        static let replyCountBtnBottomConstraint: CGFloat = -20
    }
    
    struct View {
        static let userImageLayerCornerRadius: CGFloat = 20
        static let commentNumberOfLines = 0
    }
    
    struct Font {
        static let nameFont = UIFont.systemFont(ofSize: 12)
        static let dateFont = UIFont.systemFont(ofSize: 12)
        static let commentFont = UIFont.systemFont(ofSize: 12)
        static let replyCountBtnFont = UIFont.systemFont(ofSize: 12)
    }
}
