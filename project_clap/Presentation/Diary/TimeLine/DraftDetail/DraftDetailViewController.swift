import Foundation
import UIKit

class DraftDetailViewController: UIViewController {
    
    private let recievedTimelineCellData: TimelineCellData
    
    private lazy var ui: DraftDetailUI = {
        let ui = DraftDetailUIImpl()
        ui.viewController = self
        return ui
    }()
    
    init(timelineCellData: TimelineCellData) {
        recievedTimelineCellData = timelineCellData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        print("LLLLLLLLLLLLLLLLLLLLLLLLLLLL")
        print(recievedTimelineCellData)
    }
}
