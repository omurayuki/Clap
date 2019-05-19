import Foundation
import UIKit
import RxSwift
import RxCocoa

class PasswordEditViewController: UIViewController {
    
    private lazy var ui: PasswordEditUI = {
        let ui = PasswordEditUIImpl()
        ui.viewController = self
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup()
    }
}
