import Foundation
import UIKit

protocol MypageRouting: Routing {
    func showSettingsPage(vc: UIViewController)
    func showEditPage(vc: UIViewController, uid: String)
}

final class MypageRoutingImpl: MypageRouting {
    var viewController: UIViewController?
    
    func showSettingsPage(vc: UIViewController) {
        vc.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    func showEditPage(vc: UIViewController, uid: String) {
        vc.navigationController?.pushViewController(MypageEditViewController(uid: uid), animated: true)
    }
}
