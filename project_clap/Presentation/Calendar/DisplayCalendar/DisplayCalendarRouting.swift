import Foundation
import UIKit

protocol DisplayCalendarRouting: Routing {
    func showRegistCalendar(date: Date, modalTransion: ModalTransitionDelegate)
}

final class DisplayCalendarRoutingImpl: DisplayCalendarRouting {
    
    weak var viewController: UIViewController?
    
    func showRegistCalendar(date: Date, modalTransion: ModalTransitionDelegate) {
        let vc = RegistCalendarViewController(selectedDate: date, viewModel: RegistCalendarViewModel())
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = modalTransion
        viewController?.present(vc, animated: true)
    }
}
