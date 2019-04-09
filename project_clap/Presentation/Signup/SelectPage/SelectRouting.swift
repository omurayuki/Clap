import Foundation
import UIKit

protocol SelectRouting: Routing {
    func showTeamInfoRegist()
    func showTeamIdWrite()
}

final class SelectRoutingImpl: SelectRouting {
    
    weak var viewController: UIViewController?
    
    func showTeamInfoRegist() {
        let vc = TeamInfoRegistViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTeamIdWrite() {
        let vc = TeamIdWriteViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
