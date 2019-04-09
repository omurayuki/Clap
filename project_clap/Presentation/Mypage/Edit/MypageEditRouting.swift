import Foundation
import UIKit

protocol MypageEditRouting: Routing {
    func showPrev(vc: UIViewController)
}

final class MypageEditRoutingImpl: MypageEditRouting {
    
    var viewController: UIViewController?
    
    func showPrev(vc: UIViewController) {
        guard let navi = vc.navigationController else { return }
        navi.popViewController(animated: true)
    }
}
