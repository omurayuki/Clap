import Foundation
import UIKit
import RxSwift
import RxCocoa

class DiaryGroupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension DiaryGroupViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.group()
    }
}
