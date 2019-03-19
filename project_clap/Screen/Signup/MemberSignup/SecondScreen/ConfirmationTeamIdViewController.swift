import Foundation
import UIKit
import RxSwift
import RxCocoa

class ConfirmationTeamIdViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var recievedTeamId: String
    
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
        self.recievedTeamId = teamId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(storeName: R.string.locarizable.confirmation(), vc: self)
        ui.confirmationTeamId.text = recievedTeamId
        setupViewModel()
    }
}

extension ConfirmationTeamIdViewController {
    
    private func setupViewModel() {
        ui.confirmBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.confirmBtn.bounce(completion: {
                    self?.routing.showMemberInfoRegist()
                })
            }).disposed(by: disposeBag)
        
        ui.cancelBtn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.cancelBtn.bounce(completion: {
                    self?.routing.showTop()
                })
            }).disposed(by: disposeBag)
    }
}
