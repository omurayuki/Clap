import Foundation
import UIKit

protocol SubmittedDetailRouting: Routing {
    func showReply(vc: UIViewController)
    func showReplyAndOpeningField(vc: UIViewController, completion: @escaping () -> Void)
}

final class SubmittedDetailRoutingImpl: SubmittedDetailRouting {
    
    weak var viewController: UIViewController?
    
    func showReply(vc: UIViewController) {
        viewController?.present(vc, animated: true)
    }
    
    func showReplyAndOpeningField(vc: UIViewController, completion: @escaping () -> Void) {
        viewController?.present(vc, animated: true, completion: {
            completion()
        })
    }
}
