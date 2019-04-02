import UIKit

protocol TimeLineRouting: Routing {
    func showDiaryRegist()
    func showDiaryGroup()
}

final class TimeLineRoutingImpl2: TimeLineRouting {
    
    weak var viewController: UIViewController?
    
    func showDiaryRegist() {
        let vc = DiaryRegistViewController()
        viewController?.present(vc, animated: true)
    }
    
    func showDiaryGroup() {
        let vc = DiaryGroupViewController()
        viewController?.present(vc, animated: true)
    }
}
