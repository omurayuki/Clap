import UIKit
import RxSwift
import RxCocoa
import Firebase

class TimeLineViewController: UIViewController {
    //画像
    //マイページで自分の日記一覧見れる機能
    //カレンダーで提出した自分の最新日記表示and詳細見れる
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
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
            }
            TimelineSingleton.sharedInstance.sections = TableSection.group(rowItems: data ?? [TimelineCellData](), by: { headline in
                DateOperator.firstDayOfMonth(date: headline.date ?? Date())
            })
            self?.hideIndicator()
            self?.ui.timelineTableView.reloadData()
        }
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
        cell.configureInit(image: "cellDetail.image",
                           title: cellDetail.title ?? "",
                           name: cellDetail.name ?? "",
                           time: cellDetail.time ?? "")
        return cell
    }
}

extension TimeLineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let timelineCellData = TimelineSingleton.sharedInstance.sections[indexPath.section].rowItems[indexPath.row]
        let submit = TimelineSingleton.sharedInstance.sections[indexPath.section].rowItems[indexPath.row].submit
        switch submit {
        case true:  routing.showSubmittedDiary(timelineData: timelineCellData)
        case false: routing.showDraftDiary(timelineData: timelineCellData)
        default:    break
        }
    }
}

//// MARK:- Delegate
extension TimeLineViewController: DiaryDelegate {
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

extension TimeLineViewController: IndicatorShowable {}
