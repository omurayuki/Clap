import Foundation
import RxSwift
import RxCocoa
import FirebaseFirestore

class ReplyViewController: UIViewController {
    #warning("structで情報の塊として作成")
    private var userImage: String
    private var name: String
    private var time: String
    private var comment: String
    private var commentId: String
    private var viewModel: ReplyViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    lazy var ui: ReplyUI = {
        let ui = ReplyUIImpl()
        ui.viewController = self
        ui.replyTable.dataSource = self
        ui.replyTable.delegate = self
        return ui
    }()
    
    init(userImage: String, name: String, time: String, comment: String, commentId: String) {
        self.userImage = userImage
        self.name = name
        self.time = time
        self.comment = comment
        self.commentId = commentId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupUI(userImage: userImage, name: name, time: time, comment: comment)
        viewModel = ReplyViewModel()
        setupViewModel()
        #warning("Constファイルでkeysakusei")
        #warning("userdefsultとsingletonを直接呼ばない")
        
        fetchReplies(teamId: AppUserDefaults.getValue(keyName: "teamId"),
                     diaryId: DiarySingleton.sharedInstance.diaryId,
                     commentId: self.commentId)
    }
}

extension ReplyViewController {
    func setupViewModel() {
        ui.cancelBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.dismiss(animated: true)
            }.disposed(by: viewModel.disposeBag)
        
        ui.replyWriteField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .filter({ self.ui.replyWriteField.text?.count ?? 0 > 0 })
            .drive(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.viewModel.submitReply(reply: this.ui.replyWriteField.text ?? "", commentId: this.commentId, completion: { _, error in
                    if let _ = error {
                        AlertController.showAlertMessage(alertType: .sendCommentFailure, viewController: this)
                        return
                    }
                    this.ui.replyWriteField.text = ""
                    this.ui.replyTable.reloadData()
                })
            }).disposed(by: viewModel.disposeBag)
    }
    
    private func fetchReplies(teamId: String, diaryId: String, commentId: String) {
        showIndicator()
        self.viewModel.fetchReplies(teamId: teamId, diaryId: diaryId, commentId: commentId) { [weak self] _, error in
            guard let this = self else { return }
            if let _ = error {
                this.hideIndicator()
                AlertController.showAlertMessage(alertType: .fetchReplyFailure, viewController: this)
                return
            }
            this.hideIndicator()
            this.ui.replyTable.reloadData()
        }
    }
}

extension ReplyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReplySingleton.sharedInstance.replyId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReplyCell.self), for: indexPath) as? ReplyCell else { return UITableViewCell() }
        cell.configureInit(image: ReplySingleton.sharedInstance.image[indexPath.row],
                           name: ReplySingleton.sharedInstance.name[indexPath.row],
                           time: ReplySingleton.sharedInstance.time[indexPath.row],
                           reply: ReplySingleton.sharedInstance.reply[indexPath.row])
        return cell
    }
}

extension ReplyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReplyViewController: IndicatorShowable {}
