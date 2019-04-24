import Foundation
import Rswift
import RxCocoa

class SubmittedDetailViewController: UIViewController {
    
    private let recievedTimelineCellData: TimelineCellData
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var ui: SubmittedDetailUI = {
        let ui = SubmittedDetailUIImpl()
        ui.viewController = self
        ui.commentWriteField.delegate = self
        ui.commentTable.register(TimelineCell.self, forCellReuseIdentifier: String(describing: TimelineCell.self))
        ui.commentTable.dataSource = self
        ui.commentTable.delegate = self
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
        ui.userInfo.configureInit(image: "recievedTimelineCellData.image",
                                  name: recievedTimelineCellData.name ?? "",
                                  date: recievedTimelineCellData.date ?? Date())
        
        if recievedTimelineCellData.diaryID == DiarySingleton.sharedInstance.diaryId {
            ui.text1.text = DiarySingleton.sharedInstance.text1; ui.text2.text = DiarySingleton.sharedInstance.text2
            ui.text3.text = DiarySingleton.sharedInstance.text3; ui.text4.text = DiarySingleton.sharedInstance.text4
            ui.text5.text = DiarySingleton.sharedInstance.text5; ui.text6.text = DiarySingleton.sharedInstance.text6
        } else {
            self.showIndicator()
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .document(recievedTimelineCellData.diaryID ?? "")
                .getDocument { [weak self] (snapshot, error) in
                    if let _ = error {
                        self?.hideIndicator()
                        AlertController.showAlertMessage(alertType: .diaryFetchFailure, viewController: self ?? UIViewController())
                        return
                    }
                    self?.hideIndicator()
                    guard let data = snapshot?.data() else { return }
                    guard
                        let text1 = data["text_1"] as? String, let text2 = data["text_2"] as? String,
                        let text3 = data["text_3"] as? String, let text4 = data["text_4"] as? String,
                        let text5 = data["text_5"] as? String, let text6 = data["text_6"] as? String
                        else { return }
                    
                    self?.ui.text1.text = text1; self?.ui.text2.text = text2
                    self?.ui.text3.text = text3; self?.ui.text4.text = text4
                    self?.ui.text5.text = text5; self?.ui.text6.text = text6
                    DiarySingleton.sharedInstance.diaryId = self?.recievedTimelineCellData.diaryID
                    DiarySingleton.sharedInstance.text1 = text1; DiarySingleton.sharedInstance.text2 = text2
                    DiarySingleton.sharedInstance.text3 = text3; DiarySingleton.sharedInstance.text4 = text4
                    DiarySingleton.sharedInstance.text5 = text5; DiarySingleton.sharedInstance.text5 = text6
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
    }
}

extension SubmittedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimelineCell.self), for: indexPath) as? TimelineCell else { return UITableViewCell() }
        cell.configureInit(image: "hige", title: "hoge", name: "hoge", time: "hogw")
        return cell
    }
}

extension SubmittedDetailViewController: UITableViewDelegate {
    
}

extension SubmittedDetailViewController: UITextFieldDelegate {
    
}

extension SubmittedDetailViewController: IndicatorShowable {}
