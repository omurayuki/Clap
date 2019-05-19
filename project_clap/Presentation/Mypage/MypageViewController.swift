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
        ui.mypageTable.dataSource = self
        ui.mypageTable.delegate = self
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        ui.setup()
        ui.mypageHeaderView.mypageHeaderViewController.delegate = self
        viewModel = MypageViewModel()
        fetchMypageData()
        setupViewModel()
    }
}

extension MypageViewController {
    
    private func setupViewModel() {
        ui.editBtn.rx.tap
            .bind { _ in
                self.routing.showEditPage(vc: self, uid: self.recievedUid)
            }.disposed(by: viewModel.disposeBag)
        
        ui.settingBtn.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.routing.showSettingsPage(vc: self)
            }).disposed(by: viewModel.disposeBag)
    }
    
    private func fetchMypageData() {
        viewModel.fetchMypageData(uid: recievedUid) { [weak self] data in
            self?.hideIndicator()
            self?.ui.belongTeam.text = data.team
            self?.ui.username.text = data.name
            self?.ui.position.text = data.role
            self?.ui.teamId.text = data.teamId
        }
    }
}

extension MypageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TimelineSingleton.sharedInstance.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimelineSingleton.sharedInstance.sections[section].rowItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = TimelineSingleton.sharedInstance.sections[section].sectionItem
        return DateFormatter().convertToMonthAndYears(date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimelineCell.self), for: indexPath) as? TimelineCell else { return UITableViewCell() }
        let cellDetail = TimelineSingleton.sharedInstance.sections[indexPath.section].rowItems[indexPath.row]
        cell.configureInit(image: "cellDetail.image",
                           title: cellDetail.title ?? "",
                           name: cellDetail.name ?? "",
                           time: cellDetail.time ?? "")
        return cell
    }
}

extension MypageViewController: UITableViewDelegate {
    
}

//// MARK:- Delegate
extension MypageViewController: DiaryDelegate {
    func reloadData() {
        ui.mypageTable.reloadData()
    }
    
    func showTimelineIndicator() {
        showIndicator()
    }
    
    func hideTimelineIndicator() {
        hideIndicator()
    }
}

extension MypageViewController: IndicatorShowable {}
