import UIKit

class TimeLineHeaderController: UIViewController {
    
    private lazy var timeLineSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: [R.string.locarizable.time_line(), R.string.locarizable.submitted(), R.string.locarizable.draft()])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension TimeLineHeaderController {
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.98, alpha: 1)
        view.addSubview(timeLineSegment)
        timeLineSegment.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(constant: view.frame.size.width - 10 * 2)
            .activate()
    }
}
