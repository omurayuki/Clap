import Foundation
import UIKit
import RxSwift
import RxCocoa

class DraftDetailViewController: UIViewController {
    
    private let recievedTimelineCellData: TimelineCellData
    private var viewModel: DraftDetailViewModel!
    let activityIndicator = UIActivityIndicatorView()
    weak var delegate: TimelineDelegate?
    
    private lazy var ui: DraftDetailUI = {
        let ui = DraftDetailUIImpl()
        ui.viewController = self
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
        viewModel = DraftDetailViewModel(text1: ui.text1.rx.text.orEmpty.asDriver(),
                                         text2: ui.text2.rx.text.orEmpty.asDriver(),
                                         text3: ui.text3.rx.text.orEmpty.asDriver(),
                                         text4: ui.text4.rx.text.orEmpty.asDriver(),
                                         text5: ui.text5.rx.text.orEmpty.asDriver(),
                                         text6: ui.text6.rx.text.orEmpty.asDriver())
        setupViewModel()
        fetchDiaryDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
    }
}

extension DraftDetailViewController {
    
    private func setupViewModel() {
        
        viewModel.isBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isEnable in
                guard let this = self else { return }
                this.ui.submitBtn.isHidden = !isEnable
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.isCountEnable.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isCountOver in
                guard let this = self else { return }
                let arr = [this.ui.text1, this.ui.text2, this.ui.text3, this.ui.text4, this.ui.text5, this.ui.text6]
                for tuple in arr.enumerated() {
                    tuple.element.textColor = isCountOver[tuple.offset] ? .red : .black
                    if isCountOver[tuple.offset] { AlertController.showAlertMessage(alertType: .overChar, viewController: this) }
                }
            }).disposed(by: viewModel.disposeBag)
        
        ui.draftBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.showIndicator()
                this.viewModel.registDiary(text1: this.ui.text1.text ?? "", text2: this.ui.text2.text ?? "",
                                           text3: this.ui.text3.text ?? "", text4: this.ui.text4.text ?? "",
                                           text5: this.ui.text5.text ?? "", text6: this.ui.text6.text ?? "",
                                           stringDate: this.ui.submitDateField.text ?? "", diaryId: DiarySingleton.sharedInstance.diaryId, submitted: false, completion: { (_, error) in
                                            if let _ = error {
                                                AlertController.showAlertMessage(alertType: .registDiaryFailure, viewController: this)
                                                this.hideIndicator()
                                                return
                                            }
                                            this.hideIndicator()
                                            this.delegate?.reloadData()
                                            this.navigationController?.popViewController(animated: true)
                })
            }).disposed(by: viewModel.disposeBag)

        ui.submitBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.ui.submitBtn.bounce(completion: {
                    this.showIndicator()
                    this.viewModel.registDiary(text1: this.ui.text1.text ?? "", text2: this.ui.text2.text ?? "",
                                               text3: this.ui.text3.text ?? "", text4: this.ui.text4.text ?? "",
                                               text5: this.ui.text5.text ?? "", text6: this.ui.text6.text ?? "",
                                               stringDate: this.ui.submitDateField.text ?? "", diaryId: DiarySingleton.sharedInstance.diaryId, submitted: true, completion: { (_, error) in
                                                if let _ = error {
                                                    AlertController.showAlertMessage(alertType: .registDiaryFailure, viewController: this)
                                                    this.hideIndicator()
                                                    return
                                                }
                                                this.hideIndicator()
                                                this.delegate?.reloadData()
                                                this.navigationController?.popViewController(animated: true)
                    })
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.datePicker.rx.controlEvent(.allEvents)
            .bind { [weak self] _ in
                self?.ui.submitDateField.text = self?.ui.formatter.convertToMonthAndYears(self?.ui.datePicker.date)
            }.disposed(by: viewModel.disposeBag)
        
        ui.submitDateField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.submitDateField.resignFirstResponder()
            }).disposed(by: viewModel.disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: DisposeBag())
    }
    
    private func fetchDiaryDetail() {
        showIndicator()
        view.isUserInteractionEnabled = false
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
            self?.ui.submitDateField.text = data?[6]
            self?.ui.text1.text = data?[0]; self?.ui.text2.text = data?[1]
            self?.ui.text3.text = data?[2]; self?.ui.text4.text = data?[3]
            self?.ui.text5.text = data?[4]; self?.ui.text6.text = data?[5]
        }
    }
}

extension DraftDetailViewController: IndicatorShowable {}
