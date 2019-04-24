import Foundation
import UIKit

protocol TimelineHeaderUI: UI {
    var timeLineSegment: UISegmentedControl { get }
    
    func setupUI(vc: UIViewController)
}

final class TimelineHeaderUIImpl: TimelineHeaderUI {
    
    weak var viewController: UIViewController?
    
    private(set) var timeLineSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: [R.string.locarizable.time_line(), R.string.locarizable.submitted(), R.string.locarizable.draft()])
        sc.selectedSegmentIndex = 0
        return sc
    }()
}

extension TimelineHeaderUIImpl {
    func setupUI(vc: UIViewController) {
        vc.view.backgroundColor = UIColor(white: 0.98, alpha: 1)
        vc.view.addSubview(timeLineSegment)
        timeLineSegment.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(constant: vc.view.frame.size.width - 10 * 2)
            .activate()
    }
}
