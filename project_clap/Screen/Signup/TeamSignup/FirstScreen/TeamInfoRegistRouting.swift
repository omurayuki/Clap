import Foundation
import UIKit

protocol TeamInfoRegistRouting: Routing {
    func RepresentMemberRegister()
}

final class TeamInfoRegistRoutingImpl: TeamInfoRegistRouting {
    
    weak var viewController: UIViewController?
    
    func RepresentMemberRegister() {
        let vc = RepresentMemberRegisterViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
