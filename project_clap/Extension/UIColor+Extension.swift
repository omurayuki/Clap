import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let colorV = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let corloR = CGFloat(Int(colorV[0] + colorV[1], radix: 16) ?? 0) / 255.0
        let colorG = CGFloat(Int(colorV[2] + colorV[3], radix: 16) ?? 0) / 255.0
        let colorB = CGFloat(Int(colorV[4] + colorV[5], radix: 16) ?? 0) / 255.0
        self.init(red: corloR, green: colorG, blue: colorB, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}
