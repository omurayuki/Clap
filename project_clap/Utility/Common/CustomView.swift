import Foundation
import UIKit

class CustomView: UIView {
    
    let underline: UIView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        composeUnderline()
    }
    
    private func composeUnderline() {
        underline.frame = CGRect(x: 20, y: frame.height + 10, width: frame.width - 40, height: 0.5)
        underline.backgroundColor = AppResources.ColorResources.shallowBlueColor
        addSubview(underline)
        bringSubviewToFront(underline)
    }
}
