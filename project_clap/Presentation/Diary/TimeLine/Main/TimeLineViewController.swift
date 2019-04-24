import UIKit
import RxSwift
import RxCocoa
import Firebase

class TimeLineViewController: UIViewController, TimelineDelegate {
    
    //詳細
    //下書き修正(提出or再下書き) 提出するとsubmitをtrue
    //コメント(提出済み日記にのみ)
    //リプライ
    //マイページで自分の日記一覧見れる機能
    //カレンダーで提出した自分の最新日記表示and詳細見れる
    //rxに全て置き換える calendarの前に
    
    private var viewModel: TimelineViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    lazy var ui: TimeLineUI = {
        let ui = TimeLineUIImpl()
        ui.viewController = self
        ui.timelineTableView.dataSource = self
        ui.timelineTableView.delegate = self
        return ui
    }()
    
    private lazy var routing: TimeLineRouting = {
        let routing = TimeLineRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.timelineHeaderView.timelineHeaderController.delegate = self
        ui.hiddenBtn()
        viewModel = TimelineViewModel()
        setupViewModel()
        fetchDiaries()
    }
}

extension TimeLineViewController {
    
    private func setupViewModel() {
        ui.menuBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.menuBtn.bounce(completion: {
                    guard let this = self else { return }
                    this.ui.selectedTargetMenu(vc: this)
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.memberBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.memberBtn.bounce(completion: {
                    guard let this = self else { return }
                    this.ui.selectedTargetMenu(vc: this)
                    this.routing.showDiaryGroup()
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.diaryBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.ui.diaryBtn.bounce(completion: {
                    guard let this = self else { return }
                    this.ui.selectedTargetMenu(vc: this)
                    this.routing.showDiaryRegist()
                })
            }).disposed(by: viewModel.disposeBag)
    }
    
    private func fetchDiaries() {
        showIndicator()
        viewModel.fetchDiaries { [weak self] (data, error) in
            if let _ = error {
                self?.hideIndicator()
                AlertController.showAlertMessage(alertType: .logoutFailure, viewController: self ?? UIViewController())
            }
            TimelineSingleton.sharedInstance.sections = TableSection.group(rowItems: data ?? [TimelineCellData](), by: { headline in
                DateOperator.firstDayOfMonth(date: headline.date ?? Date())
            })
            self?.hideIndicator()
            self?.ui.timelineTableView.reloadData()
        }
    }
}

//// MARK:- Delegate
extension TimeLineViewController {
    func reloadData() {
        ui.timelineTableView.reloadData()
    }
    
    func showTimelineIndicator() {
        showIndicator()
    }
    
    func hideTimelineIndicator() {
        hideIndicator()
    }
}

extension TimeLineViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TimelineSingleton.sharedInstance.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = TimelineSingleton.sharedInstance.sections[section].sectionItem
        return DateFormatter().convertToMonthAndYears(date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimelineSingleton.sharedInstance.sections[section].rowItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TimeLineResources.View.tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimelineCell.self), for: indexPath) as? TimelineCell else { return UITableViewCell() }
        let cellDetail = TimelineSingleton.sharedInstance.sections[indexPath.section].rowItems[indexPath.row]
        cell.configureInit(image: "cellDetail.image", title: cellDetail.title ?? "", name: cellDetail.name ?? "", time: cellDetail.time ?? "")
        return cell
    }
}

extension TimeLineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TimeLineViewController: IndicatorShowable {}
