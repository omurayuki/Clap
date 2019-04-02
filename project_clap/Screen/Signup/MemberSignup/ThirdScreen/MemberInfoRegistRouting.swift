import Foundation
import UIKit

protocol MemberInfoRegistRouting: Routing {
    func showTabBar()
}

final class MemberInfoRegistRoutingImpl: MemberInfoRegistRouting {
    
    weak var viewController: UIViewController?
    
    func showTabBar() {
        let vc = TabBarController(calendar: DisplayCalendarViewController(), timeLine: TimeLineViewController(), mypage: MypageViewController())
        viewController?.present(vc, animated: true)
    }
}
