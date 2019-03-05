import Foundation
import UIKit
import RxSwift
import RxCocoa

class MypageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension MypageViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.mypage_title()
    }
}
