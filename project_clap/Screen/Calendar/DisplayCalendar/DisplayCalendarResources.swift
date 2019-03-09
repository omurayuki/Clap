import Foundation
import UIKit

struct DisplayCalendarResources {
    struct Font {
        static let dateOfYearFont = UIFont.systemFont(ofSize: 15)
        static let dateOfMonth = UIFont.systemFont(ofSize: 32)
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
    }
    
    struct View {
        static let sunday = 1
        static let saturday = 7
    }
}
