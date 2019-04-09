import Foundation
import UIKit

struct DisplayCalendarResources {
    struct Font {
        static let dateOfYearFont = UIFont.systemFont(ofSize: 15)
        static let dateOfMonth = UIFont.systemFont(ofSize: 32)
        static let eventAddBtnFont = UIFont.systemFont(ofSize: 32)
        static let startTimeFont = UIFont.systemFont(ofSize: 15)
        static let endTimeFont = UIFont.systemFont(ofSize: 15)
        static let displayEventFont = UIFont.systemFont(ofSize: 20)
    }
    
    struct Constraint {
        static let dateOfYearLeftConstraint: CGFloat = 10
        static let dateOfMonthTopConstraint: CGFloat = 15
        static let dateOfMonthLeftConstraint: CGFloat = 10
        static let displayCalendarViewTopConstraint: CGFloat = 10
        static let eventFieldTopConstraint: CGFloat = 12.5
        static let monthOfDayStackHeightConstraint: CGFloat = 35
        static let calendarViewTopConstraint: CGFloat = 10
        static let calendarViewHeightConstraint: CGFloat = 250
        static let eventAddBtnRightConstraint: CGFloat = -10
        static let eventAddBtnBottomConstraint: CGFloat = -10
        static let eventAddBtnWidthConstraint: CGFloat = 50
        static let eventAddBtnHeightConstraint: CGFloat = 50
        static let wrapViewTopConstraint: CGFloat = 7
        static let wrapViewLeftConstraint: CGFloat = 7
        static let wrapViewBottomConstraint: CGFloat = -7
        static let wrapViewRightConstraint: CGFloat = -7
        static let startTimeTopConstraint:CGFloat = 5
        static let startTimeLeftConstraint:CGFloat = 10
        static let endTimeLeftConstraint: CGFloat = 10
        static let endTimeBottomConstraint: CGFloat = -5
        static let displayEventLeftConstraint: CGFloat = 20
        static let selectedDateMarkerWidthConstraint: CGFloat = 40
        static let selectedDateMarkerHeightConstraint: CGFloat = 40
        static let calendarEventDotsTopConstraint: CGFloat = 10
        static let calendarEventDotsWidthConstraint: CGFloat = 7
        static let calendarEventDotsHeightConstraint: CGFloat = 7
    }
    
    struct View {
        static let sunday = 1
        static let saturday = 7
        static let tableViewHeight: CGFloat = 65
        static let eventAddBtnCornerLayerRadius: CGFloat = 25
        static let wrapViewLayerCornerRadius: CGFloat = 10
        static let selectedDateMarkerLayerCornerRadius: CGFloat = 20
        static let calendarEventDotsLayerCornerRadius: CGFloat = 3.5
    }
}
