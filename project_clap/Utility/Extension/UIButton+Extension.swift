import UIKit

extension UIButton {
    func setupAnimation() {
        self.isUserInteractionEnabled = true
        self.alpha = 1
        let animate = CASpringAnimation(keyPath: "transform.scale")
        animate.fromValue = 0.8
        animate.toValue = 1
        animate.isRemovedOnCompletion = false
        animate.fillMode = .forwards
        self.layer.add(animate, forKey: nil)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.bounds.size.width += 80.0
        })
    }
    
    func teardownAnimation() {
        self.isUserInteractionEnabled = false
        self.alpha = 0.5
        let animate = CASpringAnimation(keyPath: "transform.scale")
        animate.fromValue = 1
        animate.toValue = 0.8
        animate.isRemovedOnCompletion = false
        animate.fillMode = .forwards
        self.layer.add(animate, forKey: nil)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.bounds.size.width -= 80.0
        })
    }
}
