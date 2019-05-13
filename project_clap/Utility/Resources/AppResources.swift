import Foundation
import UIKit

struct AppResources {
    struct ColorResources {
        static let deepBlueColor = UIColor(hex: "0800ff")
        static let subDeepBlueColor = UIColor(hex: "0400ff")
        static let normalBlueColor = UIColor(hex: "0000ff")
        static let subShallowBlueColor = UIColor(hex: "005dff")
        static let shallowBlueColor = UIColor(hex: "008cff")
        static let appCommonClearColor = UIColor(hex: "f7f7f7")
        static let appCommonClearOrangeColor = UIColor(hex: "f47442", alpha: 0.5)
    }
    
    struct FontResources {
        static let topLabelFont = UIFont.systemFont(ofSize: 100)
        static let confirmationTeamIdFont = UIFont.systemFont(ofSize: 24)
        static let defaultCellFont = UIFont.systemFont(ofSize: 13)
    }
}
