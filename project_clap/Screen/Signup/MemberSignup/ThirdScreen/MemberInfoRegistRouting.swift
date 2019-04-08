import Foundation
import UIKit

protocol MemberInfoRegistRouting: Routing {
    func showTabBar(uid: String)
}

final class MemberInfoRegistRoutingImpl: MemberInfoRegistRouting {
    
    weak var viewController: UIViewController?
    
    func showTabBar(uid: String) {
        let vc = TabBarController(calendar: DisplayCalendarViewController(), timeLine: TimeLineViewController(), mypage: MypageViewController(uid: uid))
        viewController?.present(vc, animated: true)
    }
}
