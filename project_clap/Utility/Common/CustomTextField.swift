import Foundation
import UIKit

class CustomTextField: UITextField {
    
    let underline: UIView = UIView()

    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = 50
        composeUnderline()
    }
    
    private func composeUnderline() {
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 2.5)
        underline.backgroundColor = AppResources.ColorResources.shallowBlueColor
        addSubview(underline)
        bringSubviewToFront(underline)
    }
}
