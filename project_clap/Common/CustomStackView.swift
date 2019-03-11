import Foundation
import UIKit

class CustomStackView: UIStackView {
    
    let underline: UIView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        composeUnderline()
    }
    
    private func composeUnderline() {
        underline.frame = CGRect(x: 20, y: frame.height, width: frame.width - 40, height: 2.5)
        underline.backgroundColor = AppResources.ColorResources.shallowBlueColor
        addSubview(underline)
        bringSubviewToFront(underline)
    }
}
