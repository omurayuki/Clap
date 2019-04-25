import Foundation
import Rswift
import RxCocoa

class SubmittedDetailViewController: UIViewController {
    
    private let recievedTimelineCellData: TimelineCellData
    private var viewModel: SubmittedDetailViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var ui: SubmittedDetailUI = {
        let ui = SubmittedDetailUIImpl()
        ui.viewController = self
        ui.commentWriteField.delegate = self
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
        viewModel = SubmittedDetailViewModel()
        configureInitUserData()
        if recievedTimelineCellData.diaryID == DiarySingleton.sharedInstance.diaryId {
            setdiaryDataToSingleton()
        } else {
            fetchDiaryDetail()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
    }
}

extension SubmittedDetailViewController {
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: commentCell.self), for: indexPath) as? commentCell else { return UITableViewCell() }
        cell.configureInit(image: "image", name: "小村祐希", date: "21:20", comment: "hogehogehogehogehogeffffhfhfhfhfhhfhfhfhfhfhhffhhccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccogehogehogehge")
        return cell
    }
}

extension SubmittedDetailViewController: UITableViewDelegate {
    
}

extension SubmittedDetailViewController: UITextFieldDelegate {
    
}

extension SubmittedDetailViewController: IndicatorShowable {}
