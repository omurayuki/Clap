import Foundation
import UIKit

protocol TimeLineRouting: Routing {
    func showDiaryRegist()
}

final class TimeLineRoutingImpl: TimeLineRouting {
    
    weak var viewController: UIViewController?
    
    func showDiaryRegist() {
        let vc = DiaryRegistViewController()
        viewController?.present(vc, animated: true)
    }
}
