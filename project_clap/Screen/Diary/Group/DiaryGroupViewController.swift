import Foundation
import UIKit
import RxSwift
import RxCocoa

class DiaryGroupViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var timelineBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
}

extension DiaryGroupViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = R.string.locarizable.group()
        view.addSubview(timelineBtn)
        timelineBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        timelineBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        timelineBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timelineBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupViewModel() {
        timelineBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.timelineBtn.bounce(completion: {
                    guard let `self` = self?.navigationController else { return }
                    `self`.pushViewController(TimelineViewController(), animated: true)
                })
            }).disposed(by: disposeBag)
    }
}
