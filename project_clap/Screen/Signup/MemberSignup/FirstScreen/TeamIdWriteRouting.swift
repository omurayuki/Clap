import UIKit

protocol TeamIdWriteRouting: Routing {
    func showConfirmationTeamId(teamId: String, belongTeam: String)
}

final class TeamIdWriteRoutingImpl: TeamIdWriteRouting {
    
    weak var viewController: UIViewController?
    
    func showConfirmationTeamId(teamId: String, belongTeam: String) {
        let vc = ConfirmationTeamIdViewController(teamId: teamId, belongTeam: belongTeam)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
