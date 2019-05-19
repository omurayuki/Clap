import Foundation
import UIKit

class CustomTextField: UITextField {
    
    let underline: UIView = UIView()

    override func layoutSubviews() {
        super.layoutSubviews()
        composeUnderline()
    }
    
    private func composeUnderline() {
        underline.frame = CGRect(x: 0, y: frame.height + (frame.size.height / 3), width: frame.width, height: 0.5)
        underline.backgroundColor = AppResources.ColorResources.shallowBlueColor
        addSubview(underline)
        bringSubviewToFront(underline)
    }
}
