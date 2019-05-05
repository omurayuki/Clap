import Foundation
import UIKit
import RxSwift
import RxCocoa

class TeamIdWriteViewController: UIViewController {
    
    private var viewModel: TeamIdWriteViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
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
        viewModel = TeamIdWriteViewModel(teamIdField: ui.teamIdField.rx.text.orEmpty.asObservable())
        setupViewModel()
    }
}

extension TeamIdWriteViewController {
    
    private func setupViewModel() {
        viewModel?.outputs.isConfirmBtnEnable
            .subscribe(onNext: { [weak self] isValid in
                self?.ui.confirmTeamIdBtn.isHidden = !isValid
            }).disposed(by: viewModel.disposeBag)
        //ボタンを押せない処理実装必須(でないとindicatorが消えないerrorの時)
        ui.confirmTeamIdBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.confirmTeamIdBtn.bounce(completion: {
                    self?.showIndicator()
                    guard let teamId = self?.ui.teamIdField.text else { return }
                    self?.viewModel.fetchBelongData(teamId: teamId, completion: { belong, error  in
                        if let _ = error {
                            AlertController.showAlertMessage(alertType: .loginFailed, viewController: self ?? UIViewController())
                            return
                        }
                        self?.hideIndicator()
                        self?.routing.showConfirmationTeamId(teamId: teamId)
                    })
                })
            }).disposed(by: viewModel.disposeBag)
    }
}

extension TeamIdWriteViewController: IndicatorShowable {}
