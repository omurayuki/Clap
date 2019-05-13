import UIKit

class TimeLineHeader: UIView {
    
    let timelineHeaderController = TimeLineHeaderController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(timelineHeaderController.view)
        timelineHeaderController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
