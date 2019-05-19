import UIKit

class CustomStackView: UIStackView {
    
    let underline: UIView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        composeUnderline()
    }
    
    private func composeUnderline() {
        underline.frame = CGRect(x: 20, y: frame.height + 5, width: frame.width - 40, height: 0.5)
        underline.backgroundColor = AppResources.ColorResources.shallowBlueColor
        addSubview(underline)
        bringSubviewToFront(underline)
    }
}
