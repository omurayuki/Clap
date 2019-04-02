import Foundation
import UIKit

protocol LoginRouting: Routing {
    func showTabBar()
    func showRemindPass()
}

final class LoginRoutingImpl: LoginRouting {
    
    weak var viewController: UIViewController?
    
    func showTabBar() {
        let vc = TabBarController(calendar: DisplayCalendarViewController(), timeLine: TimeLineViewController(), mypage: MypageViewController())
        viewController?.present(vc, animated: true)
    }
    
    func showRemindPass() {
        let vc = RemindPassViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
