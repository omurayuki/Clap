import Foundation
import UIKit

protocol LoginRouting: Routing {
    func showTabBar(uid: String)
    func showRemindPass()
}

final class LoginRoutingImpl: LoginRouting {
    
    weak var viewController: UIViewController?
    
    func showTabBar(uid: String) {
        let vc = TabBarController(calendar: DisplayCalendarViewController(), timeLine: TimeLineViewController(), mypage: MypageViewController(uid: uid))
        viewController?.present(vc, animated: true)
    }
    
    func showRemindPass() {
        let vc = RemindPassViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
