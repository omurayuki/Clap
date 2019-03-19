import Foundation
import UIKit

extension UILabel {
    func addUnderLine(text: String?) {
        guard let text = text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
