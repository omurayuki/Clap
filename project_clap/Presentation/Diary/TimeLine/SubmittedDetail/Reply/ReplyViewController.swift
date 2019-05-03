import Foundation
import RxSwift
import RxCocoa
import FirebaseFirestore

class ReplyViewController: UIViewController {
    
    private var userImage: String
    private var name: String
    private var time: String
    private var comment: String
    private var commentId: String
    let activityIndicator = UIActivityIndicatorView()
    let disposeBag = DisposeBag()
    
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
        setupViewModel()
        fetchDiaryDetail(teamId: AppUserDefaults.getValue(keyName: "teamId"),
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
            }.disposed(by: disposeBag)
        
        ui.replyWriteField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .filter({ self.ui.replyWriteField.text?.count ?? 0 > 0 })
            .drive(onNext: { _ in
                let replyId = RandomString.generateRandomString(length: 15)
                let setData = [
                    "replyId": replyId,
                    "image": UserSingleton.sharedInstance.image,
                    "name": UserSingleton.sharedInstance.name,
                    "userId": UserSingleton.sharedInstance.uid,
                    "reply": self.ui.replyWriteField.text ?? "",
                    "time": DateFormatter.acquireCurrentTime(),
                    "created_at": FieldValue.serverTimestamp(),
                    ] as [String : Any]
                Firebase.db
                    .collection("diary")
                    .document(AppUserDefaults.getValue(keyName: "teamId"))
                    .collection("diaries")
                    .document(DiarySingleton.sharedInstance.diaryId)
                    .collection("comments")
                    .document(self.commentId)
                    .collection("replied")
                    .document(replyId)
                    .setData(setData, completion: { error in
                        if let _ = error {
                            AlertController.showAlertMessage(alertType: .sendCommentFailure, viewController: self)
                            return
                        }
                        Firebase.db
                            .collection("diary")
                            .document(AppUserDefaults.getValue(keyName: "teamId"))
                            .collection("diaries")
                            .document(DiarySingleton.sharedInstance.diaryId)
                            .collection("comments")
                            .document(self.commentId)
                            .updateData(["replied": true])
                    })
                self.ui.replyWriteField.text = ""
                self.ui.replyTable.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func fetchDiaryDetail(teamId: String, diaryId: String, commentId: String) {
        showIndicator()
        Firebase.db
            .collection("diary")
            .document(teamId)
            .collection("diaries")
            .document(diaryId)
            .collection("comments")
            .document(commentId)
            .collection("replied")
            .order(by: "created_at", descending: true)
            .addSnapshotListener({ snapshot, error in
                if let _ = error {
                    self.hideIndicator()
                    AlertController.showAlertMessage(alertType: .fetchReplyFailure, viewController: self)
                    return
                }
                guard let snapshot = snapshot else { return }
                let documents = snapshot.documents
                var replyIdArr = [String](); var userIdArr = [String]()
                var imageArr = [String](); var nameArr = [String]()
                var timeArr = [String](); var replyArr = [String]()
                for tuple in documents.enumerated() {
                    let data = tuple.element.data()
                    guard
                        let replyId = data["replyId"] as? String, let userId = data["userId"] as? String,
                        let image = data["image"] as? String, let name = data["name"] as? String,
                        let time = data["time"] as? String, let reply = data["reply"] as? String
                        else { return }
                    replyIdArr.append(replyId); userIdArr.append(userId)
                    imageArr.append(image); nameArr.append(name)
                    timeArr.append(time); replyArr.append(reply)
                }
                ReplySingleton.sharedInstance.replyId = replyIdArr; ReplySingleton.sharedInstance.userId = userIdArr
                ReplySingleton.sharedInstance.image = imageArr; ReplySingleton.sharedInstance.name = nameArr
                ReplySingleton.sharedInstance.time = timeArr; ReplySingleton.sharedInstance.reply = replyArr
                self.hideIndicator()
                self.ui.replyTable.reloadData()
            })
    }
}

extension ReplyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReplySingleton.sharedInstance.replyId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReplyCell.self), for: indexPath) as? ReplyCell else { return UITableViewCell() }
        cell.configureInit(image: ReplySingleton.sharedInstance.image[indexPath.row], name: ReplySingleton.sharedInstance.name[indexPath.row], time: ReplySingleton.sharedInstance.time[indexPath.row], reply: ReplySingleton.sharedInstance.reply[indexPath.row])
        return cell
    }
}

extension ReplyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReplyViewController: IndicatorShowable {}
