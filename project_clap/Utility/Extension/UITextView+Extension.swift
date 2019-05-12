import UIKit

extension UITextView {
    func setupAnimation() {
        let groupAnimation = CAAnimationGroup()
        let jump = CASpringAnimation(keyPath: "position.y")
        jump.initialVelocity = 100.0
        jump.mass = 10.0
        jump.stiffness = 1500.0
        jump.damping = 50.0
        jump.fromValue = self.layer.position.y + 1.0
        jump.toValue = self.layer.position.y
        jump.duration = jump.settlingDuration
        self.layer.add(jump, forKey: nil)
        
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.clear.cgColor
        
        let flash = CASpringAnimation(keyPath: "borderColor")
        flash.damping = 7.0
        flash.stiffness = 200.0
        flash.fromValue = UIColor(red: 1.0, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
        flash.toValue = UIColor.white.cgColor
        flash.duration = flash.settlingDuration
        groupAnimation.animations = [jump, flash]
        self.layer.add(groupAnimation, forKey: nil)
    }
}
