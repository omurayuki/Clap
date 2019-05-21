import Foundation
import Rswift
import RxCocoa
import FirebaseFirestore

class SubmittedDetailViewController: UIViewController {
    
    private let recievedTimelineCellData: TimelineCellData
    private var viewModel: SubmittedDetailViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var ui: SubmittedDetailUI = {
        let ui = SubmittedDetailUIImpl()
        ui.viewController = self
        ui.commentTable.dataSource = self
        return ui
    }()
    
    private lazy var routing: SubmittedDetailRouting = {
        let routing = SubmittedDetailRoutingImpl()
        routing.viewController = self
        return routing
    }()
    
    init(timelineCellData: TimelineCellData) {
        recievedTimelineCellData = timelineCellData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = SubmittedDetailViewModel()
        setupViewModel()
        configureInitUserData()
        recievedTimelineCellData.diaryID == DiarySingleton.sharedInstance.diaryId ? setdiaryDataFromSingleton() : fetchDiaryDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
    }
}

extension SubmittedDetailViewController {
    
    private func setupViewModel() {
        ui.commentWriteField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .filter({ self.ui.commentWriteField.text?.count ?? 0 > 0 })
            .drive(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.viewModel.submitComment(comment: this.ui.commentWriteField.text ?? "", completion: { _, error in
                    if let _ = error {
                        AlertController.showAlertMessage(alertType: .sendCommentFailure, viewController: this)
                        return
                    }
                    this.ui.commentWriteField.text = ""
                    this.ui.commentTable.reloadData()
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.diaryScrollView.rx.contentOffset
            .filter({ point in point.y >= 300 })
            .take(1)
            .subscribe(onNext: { [weak self] point in
                guard let this = self else { return }
                this.viewModel.fetchComment(completion: { _, error in
                    if let _ = error {
                        AlertController.showAlertMessage(alertType: .fetchCommentfailure, viewController: this)
                        return
                    }
                    this.ui.commentTable.reloadData()
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.commentWriteField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let _ = self?.ui.commentWriteField.isFirstResponder {
                    self?.ui.commentWriteField.resignFirstResponder()
                }
            }.disposed(by: viewModel.disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: viewModel.disposeBag)
    }
    
    private func configureInitUserData() {
        ui.userInfo.configureInit(image: "recievedTimelineCellData.image",
                                  name: recievedTimelineCellData.name ?? "",
                                  date: recievedTimelineCellData.date ?? Date())
    }
    #warning("直接呼んでる")
    private func setdiaryDataFromSingleton() {
        ui.text1.text = DiarySingleton.sharedInstance.text1; ui.text2.text = DiarySingleton.sharedInstance.text2
        ui.text3.text = DiarySingleton.sharedInstance.text3; ui.text4.text = DiarySingleton.sharedInstance.text4
        ui.text5.text = DiarySingleton.sharedInstance.text5; ui.text6.text = DiarySingleton.sharedInstance.text6
    }
    
    private func fetchDiaryDetail() {
        showIndicator()
        view.isUserInteractionEnabled = false
        #warning("CONSTファイルにkeyを定義")
        #warning("userdefsultを直接呼ばない")
        viewModel.fetchDiaryDetail(
            teamId: AppUserDefaults.getValue(keyName: "teamId"),
            diaryId: recievedTimelineCellData.diaryID ?? "")
            { [weak self] (data, error) in
                if let _ = error {
                    self?.hideIndicator()
                    self?.view.isUserInteractionEnabled = true
                    AlertController.showAlertMessage(alertType: .diaryFetchFailure, viewController: self ?? UIViewController())
                    return
                }
                self?.hideIndicator()
                self?.view.isUserInteractionEnabled = true
                self?.ui.text1.text = data?[0]; self?.ui.text2.text = data?[1]
                self?.ui.text3.text = data?[2]; self?.ui.text4.text = data?[3]
                self?.ui.text5.text = data?[4]; self?.ui.text6.text = data?[5]
            }
    }
    
    func isHiddenReplyBtn(cell: CommentCell, indexPath: IndexPath) {
        cell.delegate = self
        if CommentSingleton.sharedInstance.replied[indexPath.row] == false {
            cell.replyCountBtn.isHidden = true
            cell.viewMovedOverRight.isHidden = true
        }
    }
}

extension SubmittedDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentSingleton.sharedInstance.commentId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentCell.self),
                                                       for: indexPath) as? CommentCell else { return UITableViewCell() }
        cell.configureInit(image: CommentSingleton.sharedInstance.image[indexPath.row],
                           name: CommentSingleton.sharedInstance.name[indexPath.row],
                           time: CommentSingleton.sharedInstance.time[indexPath.row],
                           comment: CommentSingleton.sharedInstance.comment[indexPath.row],
                           commentId: CommentSingleton.sharedInstance.commentId[indexPath.row],
                           identificationId: indexPath.row)
        isHiddenReplyBtn(cell: cell, indexPath: indexPath)
        return cell
    }
}
#warning("インスタンス作成はroutingの仕事")
//// MARK:- Delegate
extension SubmittedDetailViewController: CommentCellDelegate {
    
    func selectReplyBtn(index: Int) {
        let vc = ReplyViewController(userImage: CommentSingleton.sharedInstance.image[index],
                                     name: CommentSingleton.sharedInstance.name[index],
                                     time: CommentSingleton.sharedInstance.time[index],
                                     comment: CommentSingleton.sharedInstance.comment[index],
                                     commentId: CommentSingleton.sharedInstance.commentId[index])
        routing.showReply(vc: vc)
    }
    
    func selectDoingReplyBtn(index: Int) {
        let vc = ReplyViewController(userImage: CommentSingleton.sharedInstance.image[index],
                                     name: CommentSingleton.sharedInstance.name[index],
                                     time: CommentSingleton.sharedInstance.time[index],
                                     comment: CommentSingleton.sharedInstance.comment[index],
                                     commentId: CommentSingleton.sharedInstance.commentId[index])
        routing.showReplyAndOpeningField(vc: vc) {
            vc.ui.replyWriteField.becomeFirstResponder()
        }
    }
}

extension SubmittedDetailViewController: IndicatorShowable {}
