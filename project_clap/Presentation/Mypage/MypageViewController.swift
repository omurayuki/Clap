import Foundation
import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class MypageViewController: UIViewController {
    
    var recievedUid: String
    var viewModel: MypageViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        fetchMypageData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.setupInsideStack(vc: self)
        viewModel = MypageViewModel()
        self.showIndicator()
        setupViewModel()
    }
}

extension MypageViewController {
    
    private func setupViewModel() {
        ui.editBtn.rx.tap
            .bind { _ in
                self.routing.showEditPage(vc: self, uid: self.recievedUid)
            }.disposed(by: viewModel.disposeBag)
        
        ui.logoutBtn.rx.tap
            .bind { _ in
                self.ui.createLogoutAlert(vc: self, completion: {
                    do {
                        try Firebase.fireAuth.signOut()
                    } catch {
                        AlertController.showAlertMessage(alertType: .logoutFailure, viewController: self)
                    }
                })
            }.disposed(by: viewModel.disposeBag)
    }
    
    private func fetchMypageData() {
        viewModel.fetchMypageData(uid: recievedUid) { [weak self] data in
            self?.hideIndicator()
            self?.ui.belongTeam.text = data.team
            self?.ui.teamId.text = data.teamId
            self?.ui.position.text = data.role
            self?.ui.mail.text = data.mail
        }
    }
}

extension MypageViewController: IndicatorShowable {}
