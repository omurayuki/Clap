import Foundation
import UIKit

protocol DisplayCalendarRouting: Routing {
    func showRegistCalendar(date: Date)
}

final class DisplayCalendarRoutingImpl: DisplayCalendarRouting {
    
    weak var viewController: UIViewController?
    
    func showRegistCalendar(date: Date) {
        viewController?.present(RegistCalendarViewController(selectedDate: date), animated: true)
    }
}
