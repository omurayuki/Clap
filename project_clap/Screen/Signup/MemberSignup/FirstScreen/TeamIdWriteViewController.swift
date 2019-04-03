import Foundation
import UIKit
import RxSwift
import RxCocoa

class TeamIdWriteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: TeamIdWriteViewModel?
    
    private lazy var ui: TeamIdWriteUI = {
        let ui = TeamIdWriteUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: TeamIdWriteRouting = {
        let routing = TeamIdWriteRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = TeamIdWriteViewModel(teamIdField: ui.teamIdField.rx.text.orEmpty.asObservable())
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
                    guard let teamId = self?.ui.teamIdField.text else { return }
                    //次のページでfetchしているが、ここでfetchしてからbelongデータを送る、そうしないと表示が遅い
                    self?.routing.showConfirmationTeamId(teamId: teamId)
                })
            }).disposed(by: disposeBag)
    }
}
