import UIKit

protocol TimeLineRouting: Routing {
    func showDiaryRegist()
    func showSubmittedDiary(timelineData: TimelineCellData)
    func showDraftDiary(timelineData: TimelineCellData)
}

final class TimeLineRoutingImpl: TimeLineRouting {
    
    weak var viewController: UIViewController?
    
    func showDiaryRegist() {
        let vc = DiaryRegistViewController()
        viewController?.present(vc, animated: true)
    }
    
    func showSubmittedDiary(timelineData: TimelineCellData) {
        let vc = SubmittedDetailViewController(timelineCellData: timelineData)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDraftDiary(timelineData: TimelineCellData) {
        let vc = DraftDetailViewController(timelineCellData: timelineData)
        vc.delegate = viewController as? DiaryDelegate
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
