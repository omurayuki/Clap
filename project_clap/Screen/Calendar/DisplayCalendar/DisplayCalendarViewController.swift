import Foundation
import UIKit
import RxSwift
import RxCocoa

class DisplayCalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension DisplayCalendarViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.calendar_title()
    }
}
