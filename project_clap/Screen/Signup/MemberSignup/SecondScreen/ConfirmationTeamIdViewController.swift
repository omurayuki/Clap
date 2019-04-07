import Foundation
import UIKit
import RxSwift
import RxCocoa

class ConfirmationTeamIdViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var recievedTeamId: String
    var recievedBelongTeam: String
    
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
    
    init(teamId: String, belongTeam: String) {
        recievedTeamId = teamId
        recievedBelongTeam = belongTeam
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(storeName: R.string.locarizable.confirmation(), vc: self)
        SignupRepositoryImpl().fetchBelongData(teamId: recievedTeamId) { description in
            self.ui.confirmationTeamTitle.text = "あなたのチームは\(description ?? "")でお間違いないですか？"
        }
        ui.confirmationTeamId.text = recievedTeamId
        setupViewModel()
    }
}

extension ConfirmationTeamIdViewController {
    
    private func setupViewModel() {
        ui.confirmBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.confirmBtn.bounce(completion: {
                    self?.routing.showMemberInfoRegist(teamId: self?.recievedTeamId ?? "")
                })
            }).disposed(by: disposeBag)
        
        ui.cancelBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.cancelBtn.bounce(completion: {
                    self?.routing.showTop()
                })
            }).disposed(by: disposeBag)
    }
}
