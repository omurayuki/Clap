import Foundation
import UIKit

protocol ReplyUI: UI {
    
    func setupUI()
}

final class ReplyUIImpl: ReplyUI {
    var viewController: UIViewController?
}

extension ReplyUIImpl {
    func setupUI() {
        
    }
}
