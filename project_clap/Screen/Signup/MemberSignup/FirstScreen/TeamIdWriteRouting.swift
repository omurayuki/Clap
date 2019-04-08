import UIKit

protocol TeamIdWriteRouting: Routing {
    func showConfirmationTeamId(teamId: String)
}

final class TeamIdWriteRoutingImpl: TeamIdWriteRouting {
    
    weak var viewController: UIViewController?
    
    func showConfirmationTeamId(teamId: String) {
        let vc = ConfirmationTeamIdViewController(teamId: teamId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
