import Foundation
import UIKit

class ModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

