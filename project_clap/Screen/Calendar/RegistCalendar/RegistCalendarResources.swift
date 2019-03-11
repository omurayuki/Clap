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
    }
    
    struct Font {
        static let titleFieldFont = UIFont.systemFont(ofSize: 32)
        static let dateFont = UIFont.systemFont(ofSize: 17)
        static let timeFont = UIFont.systemFont(ofSize: 29)
        static let betweenFont = UIFont.boldSystemFont(ofSize: 24)
    }
}
