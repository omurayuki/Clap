import Foundation
import UIKit

class MypageHeaderViewController: UIViewController {
    
    private var viewModel: MypageHeaderViewModel!
    weak var delegate: DiaryDelegate?
    
    private lazy var ui: MypageHeaderUI = {
        let ui = MypageHeaderUIImpl()
        ui.viewController = self
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MypageHeaderViewModel()
        ui.setupUI(vc: self)
        setupViewModel()
    }
}

extension MypageHeaderViewController {
    private func setupViewModel() {
        ui.mypageSegment.rx.value.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] num in
                switch num {
                case Segment.Mypage.submitted.rawValue:
                    self?.fetchSubmittedDiaries(submit: true, uid: UserSingleton.sharedInstance.uid)
                case Segment.Mypage.draft.rawValue:
                    self?.fetchDraftDiaries(submit: false, uid: UserSingleton.sharedInstance.uid)
                default: break
                }
            }).disposed(by: viewModel.disposeBag)
    }
    
    func fetchSubmittedDiaries(submit: Bool, uid: String) {
        self.delegate?.showTimelineIndicator()
        viewModel.fetchSubmittedDiaries(submit: submit, uid: uid) { [weak self] (data, error) in
            if let _ = error {
                self?.delegate?.hideTimelineIndicator()
            }
            TimelineSingleton.sharedInstance.sections = TableSection.group(rowItems: data ?? [TimelineCellData](), by: { headline in
                DateOperator.firstDayOfMonth(date: headline.date ?? Date())
            })
            self?.delegate?.hideTimelineIndicator()
            self?.delegate?.reloadData()
        }
    }
    
    func fetchDraftDiaries(submit: Bool, uid: String) {
        self.delegate?.showTimelineIndicator()
        viewModel.fetchSubmittedDiaries(submit: submit, uid: uid) { [weak self] (data, error) in
            if let _ = error {
                self?.delegate?.hideTimelineIndicator()
            }
            TimelineSingleton.sharedInstance.sections = TableSection.group(rowItems: data ?? [TimelineCellData](), by: { headline in
                DateOperator.firstDayOfMonth(date: headline.date ?? Date())
            })
            self?.delegate?.hideTimelineIndicator()
            self?.delegate?.reloadData()
        }
    }
}
