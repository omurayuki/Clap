import Foundation
import UIKit
import RxSwift
import RxCocoa
//validationであれば遷移, なければアラート
class TeamIdWriteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: TeamIdWriteViewModel?
    
    private lazy var ui: TeamIdWriteUI = {
        let ui = TeamIdWriteUIImpl()
        ui.viewController = self
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        viewModel = TeamIdWriteViewModel(teamIdField: ui.teamIdField.rx.text.orEmpty.asObservable())
        setupViewModel()
    }
}

extension TeamIdWriteViewController {
    
    private func setupViewModel() {
        viewModel?.outputs.isConfirmBtnEnable
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.confirmTeamIdBtn.isHidden = !isValid
            }).disposed(by: disposeBag)
        
        ui.confirmTeamIdBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.confirmTeamIdBtn.bounce(completion: {
                    guard let navi = self?.navigationController else { return }
                    guard let teamId = self?.ui.teamIdField.text else { return }
                    navi.pushViewController(ConfirmationTeamIdViewController(teamId: teamId), animated: true)
                })
            }).disposed(by: disposeBag)
    }
}
