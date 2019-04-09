import Foundation
import UIKit

protocol RepresentMemberRegisterRouting: Routing {
    func showTabBar(uid: String)
}

final class RepresentMemberRegisterRoutingImpl: RepresentMemberRegisterRouting {
    
    weak var viewController: UIViewController?
    
    func showTabBar(uid: String) {
        let vc = TabBarController(calendar: DisplayCalendarViewController(), timeLine: TimeLineViewController(), mypage: MypageViewController(uid: uid))
        viewController?.present(vc, animated: true)
    }
}
