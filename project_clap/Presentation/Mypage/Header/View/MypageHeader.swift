import UIKit

class MypageHeader: UIView {
    
    let mypageHeaderViewController = MypageHeaderViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mypageHeaderViewController.view)
        mypageHeaderViewController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
