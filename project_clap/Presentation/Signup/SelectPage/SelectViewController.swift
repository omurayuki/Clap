import Foundation
import RxSwift
import RxCocoa

class SelectViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var ui: SelectUI = {
        let ui = SelectUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: SelectRouting = {
        let routing = SelectRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(storeName: R.string.locarizable.type())
        setupViewModel()
    }
}

extension SelectViewController {
    
    private func setupViewModel() {
        ui.teamRegistBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _  in
                self?.ui.teamRegistBtn.bounce(completion: {
                    self?.routing.showTeamInfoRegist()
                })
            }).disposed(by: disposeBag)
        
        ui.memberRegistBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _  in
                self?.ui.memberRegistBtn.bounce(completion: {
                    self?.routing.showTeamIdWrite()
                })
            }).disposed(by: disposeBag)
    }
}
