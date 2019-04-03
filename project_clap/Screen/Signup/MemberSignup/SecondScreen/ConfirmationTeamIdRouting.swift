import Foundation
import UIKit

protocol ConfirmationTeamIdRouting: Routing {
    func showMemberInfoRegist(teamId: String)
    func showTop()
}

final class ConfirmationTeamIdRoutingImpl: ConfirmationTeamIdRouting {
    
    weak var viewController: UIViewController?
    
    func showMemberInfoRegist(teamId: String) {
        let vc = MemberInfoRegistViewController(teamId: teamId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTop() {
        guard let count = viewController?.navigationController?.viewControllers.count else { return }
        guard let vc = viewController?.navigationController?.viewControllers[count - 4] else { return }
        viewController?.navigationController?.popToViewController(vc, animated: true)
    }
}
