import Foundation
import UIKit

protocol TopRouting: Routing {
    func showSignup()
    func showLogin()
}

final class TopRoutingImple: TopRouting {
    
    weak var viewController: UIViewController?
    
    func showSignup() {
        let vc = SelectViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showLogin() {
        let vc = LoginViewCountroller()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
