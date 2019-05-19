import Foundation
import RxSwift
import RxCocoa
import RealmSwift
 
class TopViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var ui: TopUI! = {
        let ui = TopUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: TopRouting = {
        let routing = TopRoutingImple()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup()
        setupViewModel()
    }
}

extension TopViewController {
    
    private func setupViewModel() {
        ui.loginBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.loginBtn.bounce(completion: {
                    self?.routing.showLogin()
                })
            }).disposed(by: disposeBag)
        
        ui.signupBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.signupBtn.bounce(completion: {
                    self?.routing.showSignup()
                })
            }).disposed(by: disposeBag)
    }
}
