import Foundation
import Rswift
import RxCocoa
import FirebaseFirestore

class SubmittedDetailViewController: UIViewController {
    
    //replyされたらcommentDocumentのrepliedをtrueにする　それを見てcellのボタンを表示するかどうか判定する できた！！！！！
    //youtubeと同じreply画面　コメント画面に返信を表示するボタンを押せばmodalで単純に表示　コメントをするボタンを押せばmodalで同じ画面表示させて同時にtextfieldにフォーカス当てる
    //次、delegateで返信を表示するボタンがタップされたときに、commentIdを渡してそのコメントの詳細を次の画面に表示する　そしてそのコメントに紐づいているreplyを全て表示する
    
    
    private let recievedTimelineCellData: TimelineCellData
    private var viewModel: SubmittedDetailViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var ui: SubmittedDetailUI = {
        let ui = SubmittedDetailUIImpl()
        ui.viewController = self
        ui.commentTable.dataSource = self
        return ui
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
        recievedTimelineCellData.diaryID == DiarySingleton.sharedInstance.diaryId ? setdiaryDataToSingleton() : fetchDiaryDetail()
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
            .drive(onNext: { _ in
                let commentId = RandomString.generateRandomString(length: 15)
                let setData = [
                    "commentId": commentId,
                    "image": UserSingleton.sharedInstance.image,
                    "name": UserSingleton.sharedInstance.name,
                    "userId": UserSingleton.sharedInstance.uid,
                    "comment": self.ui.commentWriteField.text ?? "",
                    "time": DateFormatter.acquireCurrentTime(),
                    "replied": false,
                    "created_at": FieldValue.serverTimestamp(),
                    ] as [String : Any]
                Firebase.db
                    .collection("diary")
                    .document(AppUserDefaults.getValue(keyName: "teamId"))
                    .collection("diaries")
                    .document(DiarySingleton.sharedInstance.diaryId)
                    .collection("comments")
                    .document(commentId)
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
                            .updateData(["commented": true])
                    })
                self.ui.commentWriteField.text = ""
                self.ui.commentTable.reloadData()
            }).disposed(by: viewModel.disposeBag)
        
        ui.diaryScrollView.rx.contentOffset
            .filter({ point in point.y >= 300 })
            .take(1)
            .subscribe(onNext: { point in
                CommentSingleton.sharedInstance.commentId = [String](); CommentSingleton.sharedInstance.userId = [String]()
                CommentSingleton.sharedInstance.image = [String](); CommentSingleton.sharedInstance.name = [String]()
                CommentSingleton.sharedInstance.time = [String](); CommentSingleton.sharedInstance.comment = [String]()
                Firebase.db
                    .collection("diary")
                    .document(AppUserDefaults.getValue(keyName: "teamId"))
                    .collection("diaries")
                    .document(DiarySingleton.sharedInstance.diaryId)
                    .collection("comments")
                    .order(by: "created_at", descending: true)
                    .addSnapshotListener({ snapshot, error in
                        if let _ = error {
                            AlertController.showAlertMessage(alertType: .fetchCommentfailure, viewController: self)
                            return
                        }
                        guard let snapshot = snapshot else { return }
                        let documents = snapshot.documents
                        var commentIdArr = [String](); var userIdArr = [String]()
                        var imageArr = [String](); var nameArr = [String]()
                        var timeArr = [String](); var commentArr = [String]()
                        var repliedArr = [Bool]()
                        for tuple in documents.enumerated() {
                            let data = tuple.element.data()
                            guard
                                let commentId = data["commentId"] as? String, let userId = data["userId"] as? String,
                                let image = data["image"] as? String, let name = data["name"] as? String,
                                let time = data["time"] as? String, let comment = data["comment"] as? String,
                                let replied = data["replied"] as? Bool
                            else { return }
                            commentIdArr.append(commentId); userIdArr.append(userId)
                            imageArr.append(image); nameArr.append(name)
                            timeArr.append(time); commentArr.append(comment)
                            repliedArr.append(replied)
                        }
                        CommentSingleton.sharedInstance.commentId = commentIdArr; CommentSingleton.sharedInstance.userId = userIdArr
                        CommentSingleton.sharedInstance.image = imageArr; CommentSingleton.sharedInstance.name = nameArr
                        CommentSingleton.sharedInstance.time = timeArr; CommentSingleton.sharedInstance.comment = commentArr
                        CommentSingleton.sharedInstance.replied = repliedArr
                        self.ui.commentTable.reloadData()
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
    
    private func setdiaryDataToSingleton() {
        ui.text1.text = DiarySingleton.sharedInstance.text1; ui.text2.text = DiarySingleton.sharedInstance.text2
        ui.text3.text = DiarySingleton.sharedInstance.text3; ui.text4.text = DiarySingleton.sharedInstance.text4
        ui.text5.text = DiarySingleton.sharedInstance.text5; ui.text6.text = DiarySingleton.sharedInstance.text6
    }
    
    private func fetchDiaryDetail() {
        self.showIndicator()
        viewModel.fetchDiaryDetail(
            teamId: AppUserDefaults.getValue(keyName: "teamId"),
            diaryId: recievedTimelineCellData.diaryID ?? "")
            { [weak self] (data, error) in
                if let _ = error {
                    self?.hideIndicator()
                    AlertController.showAlertMessage(alertType: .diaryFetchFailure, viewController: self ?? UIViewController())
                    return
                }
                self?.hideIndicator()
                self?.ui.text1.text = data?[0]; self?.ui.text2.text = data?[1]
                self?.ui.text3.text = data?[2]; self?.ui.text4.text = data?[3]
                self?.ui.text5.text = data?[4]; self?.ui.text6.text = data?[5]
            }
    }
}

extension SubmittedDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentSingleton.sharedInstance.commentId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: commentCell.self), for: indexPath) as? commentCell else { return UITableViewCell() }
        cell.configureInit(replied: CommentSingleton.sharedInstance.replied[indexPath.row],
                           image: CommentSingleton.sharedInstance.image[indexPath.row],
                           name: CommentSingleton.sharedInstance.name[indexPath.row],
                           time: CommentSingleton.sharedInstance.time[indexPath.row],
                           comment: CommentSingleton.sharedInstance.comment[indexPath.row],
                           commentId: CommentSingleton.sharedInstance.commentId[indexPath.row])
        return cell
    }
}

extension SubmittedDetailViewController: IndicatorShowable {}
