import Foundation
import UIKit
import RxSwift
import RxCocoa

class ConfirmationTeamIdViewController: UIViewController {
    
    var viewModel: ConfirmationTeamIdViewModel!
    var recievedTeamId: String
    var recievedBelongTeam: String?
    
    private lazy var ui: ConfirmationTeamIdUI = {
        let ui = ConfirmationTeamIdUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: ConfirmationTeamIdRouting = {
        let routing = ConfirmationTeamIdRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    init(teamId: String) {
        recievedTeamId = teamId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(storeName: R.string.locarizable.confirmation(), vc: self)
        viewModel = ConfirmationTeamIdViewModel()
        setupViewModel()
        fetchBelongData(teamId: recievedTeamId)
        ui.confirmationTeamId.text = recievedTeamId
    }
}

extension ConfirmationTeamIdViewController {
    
    private func setupViewModel() {
        ui.confirmBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.confirmBtn.bounce(completion: {
                    self?.routing.showMemberInfoRegist(teamId: self?.recievedTeamId ?? "", belongTeam: self?.recievedBelongTeam ?? "")
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.cancelBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.cancelBtn.bounce(completion: {
                    self?.routing.showTop()
                })
            }).disposed(by: viewModel.disposeBag)
    }
    
    private func fetchBelongData(teamId: String) {
        viewModel.fetchBelongData(teamId: recievedTeamId) { [weak self] description in
            self?.ui.confirmationTeamTitle.text = "あなたのチームは\(description ?? "")でお間違いないですか？"
            self?.recievedBelongTeam = description ?? ""
        }
    }
}
