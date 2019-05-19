import Foundation
import UIKit

struct RegistCalendarResources {
    struct Constraint {
        static let titleFieldTopConstraint: CGFloat = 5
        static let titleFieldLeftCounstraint: CGFloat = 10
        static let titleFieldRightCounstraint: CGFloat = 10
        static let totalTimeStackTopCounstraint: CGFloat = 10
        static let totalTimeStackLeftCounstraint: CGFloat = 20
        static let totalTimeStackRightCounstraint: CGFloat = -20
        static let totalTimeStackBottomCounstraint: CGFloat = -10
        static let longdayOrShortdayStackTopCounstraint: CGFloat = 32.5
        static let longdayOrShortdayStackLeftCounstraint: CGFloat = 40
        static let longdayOrShortdayStackRightCounstraint: CGFloat = -40
        static let startTimeTopConstraint: CGFloat = 10
        static let endTimeTopConstrint: CGFloat = 10
        static let longdayOrShortdayTitleTopCounstraint: CGFloat = 10
        static let longdayOrShortdayTitleLeftCounstraint: CGFloat = 10
        static let longdayOrShortdayTitleBottomCounstraint: CGFloat = -10
        static let switchLongdayOrShortdayTopCounstraint: CGFloat = 10
        static let switchLongdayOrShortdayRightCounstraint: CGFloat = -10
        static let switchLongdayOrShortdayBottomCounstraint: CGFloat = -10
        static let detailStackTopConstraint: CGFloat = 10
        static let detailStackLeftConstraint: CGFloat = 40
        static let detailStackRightConstraint: CGFloat = -40
        static let detailTitleTopConstraint: CGFloat = 10
        static let detailTitleLeftConstraint: CGFloat = 10
        static let detailFieldTopConstraint: CGFloat = 20
        static let detailFieldLeftConstraint: CGFloat = 10
    }
    
    struct Font {
        static let titleFieldFont = UIFont.systemFont(ofSize: 24)
        static let defaultDateFont = UIFont.systemFont(ofSize: 15)
        static let timeFont = UIFont.systemFont(ofSize: 21)
        static let betweenFont = UIFont.boldSystemFont(ofSize: 24)
        static let detailFieldFont = UIFont.systemFont(ofSize: 15)
        static let largeDateFont = UIFont.systemFont(ofSize: 17)
    }
    
    struct View {
        static let frtailFieldCornerRadius: CGFloat = 5
        static let frtailFieldCornerWidth: CGFloat = 1
    }
}
