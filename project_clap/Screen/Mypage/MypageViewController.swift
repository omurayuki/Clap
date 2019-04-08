import Foundation
import UIKit
import RxSwift
import RxCocoa

class MypageViewController: UIViewController {
    
    var recievedUid: String
    var viewModel: MypageViewModel?
    var disposeBag = DisposeBag()
    
    private lazy var ui: MypageUI = {
        let ui = MypageUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: MypageRouting = {
        let routing = MypageRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    init(uid: String) {
        recievedUid = uid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.setupInsideStack(vc:self)
        fetchMypageData()
        setupViewModel()
    }
}

extension MypageViewController {
    
    private func fetchMypageData() {
        //初期化のタイミングでfetch viewdidload以前
        MypageRepositoryImpl().fetchMypageData(uid: recievedUid)
            .subscribe { [weak self] single in
                switch single {
                case .success(let data):
                    self?.ui.belongTeam.text = data.team
                    self?.ui.teamId.text = data.teamId
                    self?.ui.position.text = data.role
                    self?.ui.mail.text = data.mail
                    return
                case .error(let error):
                    print(error.localizedDescription)
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        ui.editBtn.rx.tap
            .bind { _ in
                self.routing.showEditPage(vc: self, uid: self.recievedUid)
            }.disposed(by: disposeBag)
        
        ui.logoutBtn.rx.tap
            .bind { _ in
                self.ui.createLogoutAlert(vc: self)
            }.disposed(by: disposeBag)
    }
}
