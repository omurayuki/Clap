import Foundation
import UIKit

protocol MypageHeaderUI: UI {
    var mypageSegment: UISegmentedControl { get }
    
    func setupUI(vc: UIViewController)
}

final class MypageHeaderUIImpl: MypageHeaderUI {
    
    weak var viewController: UIViewController?
    
    private(set) var mypageSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["提出済み", "コメントした日記"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
}

extension MypageHeaderUIImpl {
    func setupUI(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.view.addSubview(mypageSegment)
        mypageSegment.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(constant: vc.view.frame.size.width - 10 * 2)
            .activate()
    }
}
