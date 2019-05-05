import Foundation
import UIKit

protocol DraftDetailRouting: Routing {
    func popViewController(completion: (() -> Void)?)
}

final class DraftDetailRoutingImpl: DraftDetailRouting {
    
    weak var viewController: UIViewController?
    
    func popViewController(completion: (() -> Void)?) {
        viewController?.navigationController?.popViewController(animated: true)
        completion?()
    }
}
