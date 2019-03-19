import Foundation
import UIKit

protocol RepresentMemberRegisterRouting: Routing {
    func showTabBar()
}

final class RepresentMemberRegisterRoutingImpl: RepresentMemberRegisterRouting {
    
    weak var viewController: UIViewController?
    
    func showTabBar() {
        let vc = TabBarController(calendar: DisplayCalendarViewController(), diary: DiaryGroupViewController(), mypage: MypageViewController())
        viewController?.present(vc, animated: true)
    }
}
