import Foundation
import RxSwift
import RxCocoa
import Firebase

class DiaryRegistViewController: UIViewController {
    
    private var startPoint : CGPoint?
    private let disposeBag = DisposeBag()
    
    private lazy var ui: DiaryRegistUI = {
        let ui = DiaryRegistUIImpl()
        ui.viewController = self
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup(vc: self)
        ui.slides = ui.createSlides(vc: self, slides: 6)
        ui.setupSlideScrollView(slides: ui.slides, vc: self)
        setupViewModel()
    }
}

extension DiaryRegistViewController {
    
    private func setupViewModel() {
        ui.eventAddBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.ui.createCancelAlert(vc: this)
            }).disposed(by: disposeBag)
        
        ui.cancelBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.ui.createCancelAlert(vc: this)
            }).disposed(by: disposeBag)
        
        ui.submitBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                print(self!.ui.slides[0].text.text)
                //diary teamID date diaries
                //teamID
                //userID
                //diaryID 生成
//                Firebase.db.collection("diary")
//                    .document("teamID")
//                    .collection("date")
//                    .document("diaries")
//                    .collection("diaryID")
//                    .addDocument(data: <#T##[String : Any]#>, completion: { error in
//                    if let _ = error {
//                        return
//                    }
//                })
            }).disposed(by: disposeBag)
        
        ui.datePicker.rx.controlEvent(.allEvents)
            .bind { [weak self] _ in
                self?.ui.submitDateField.text = self?.ui.formatter.convertToMonthAndYears(self?.ui.datePicker.date)
            }.disposed(by: disposeBag)
        
        ui.diaryScrollView.rx.willBeginDragging
            .bind { [weak self] _ in
                self?.startPoint = UIScrollView().contentOffset
            }
        
        ui.diaryScrollView.rx.didScroll
            .withLatestFrom(self.ui.diaryScrollView.rx.contentOffset)
            .map { Int(round($0.x / UIScreen.main.bounds.width)) }
            .bind(to: ui.pageControl.rx.currentPage)
            .disposed(by: disposeBag)
        
        ui.diaryScrollView.rx.didScroll
            .bind { [weak self] _ in
                guard let startPoint = self?.startPoint else { return }
                self?.ui.diaryScrollView.contentOffset.y = startPoint.y
            }.disposed(by: disposeBag)
        
        ui.submitDateField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.submitDateField.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
}
