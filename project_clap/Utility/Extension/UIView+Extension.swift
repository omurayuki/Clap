import Foundation
import UIKit

extension UIView {
    func bounce() {
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .beginFromCurrentState, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func bounce(completion: (() -> Void)? = nil) {
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .beginFromCurrentState, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            completion?()
        })
    }
}
