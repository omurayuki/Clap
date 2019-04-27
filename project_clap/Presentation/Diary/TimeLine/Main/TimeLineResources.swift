import UIKit

struct TimeLineResources {
    struct Constraint {
        static let diaryBtnBottomConstraint: CGFloat = -10
        static let diaryBtnRightConstrain: CGFloat = -10
        static let BtnWidthConstraint: CGFloat = 50
        static let BtnHeightConstraint: CGFloat = 50
        static let timeLineFieldWidthConstraint: CGFloat = 150
        static let wrapViewTopConstraint: CGFloat = 10
        static let wrapViewBottomConstraint: CGFloat = -10
        static let wrapViewLeftConstraint: CGFloat = 10
        static let wrapViewRightConstraint: CGFloat = -10
        static let userImageLeftConstraint: CGFloat = 10
        static let userImageWidthConstraint: CGFloat = 45
        static let userImageHeightConstraint: CGFloat = 45
        static let diaryTitleTopConstraint: CGFloat = 15
        static let diaryTitleLeftConstraint: CGFloat = 10
        static let diaryTitleWidthConstraint: CGFloat = 250
        static let userNameTopConstraint: CGFloat = 10
        static let userNameLeftConstraint: CGFloat = 10
        static let submitTimeTopConstraint: CGFloat = 10
        static let submitTimeRightConstraint: CGFloat = -10
    }
    
    struct View {
        static let tableRowHeight: CGFloat = 70
        static let tableHeaderHeight: CGFloat = 50
        static let pickerNumberOfComponents = 1
        static let diaryBtnLayerCornerRadius: CGFloat = 25
        static let timeLineFieldLayerCornerRadius: CGFloat = 4
        static let timeLineFieldBorderWidth: CGFloat = 1
        static let userImageLayerConrnerRadius: CGFloat = 25
        static let wrapViewLayerCornerRadius: CGFloat = 10
        static let imageCornerRadius: CGFloat = 22.5
    }
    
    struct Font {
        static let diaryBtnFont = UIFont.systemFont(ofSize: 32)
        static let diaryTitleFont = UIFont.systemFont(ofSize: 15)
        static let userNameFont = UIFont.systemFont(ofSize: 12)
        static let submittedTimeFont = UIFont.systemFont(ofSize: 12)
    }
}
