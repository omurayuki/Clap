import Foundation
import UIKit

protocol MypageRouting: Routing {
    func showEditPage(vc: UIViewController, uid: String)
}

final class MypageRoutingImpl: MypageRouting {
    var viewController: UIViewController?
    
    func showEditPage(vc: UIViewController, uid: String) {
        vc.navigationController?.pushViewController(MypageEditViewController(uid: uid), animated: true)
    }
}
