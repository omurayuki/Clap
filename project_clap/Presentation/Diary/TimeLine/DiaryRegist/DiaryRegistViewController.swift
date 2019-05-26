import Foundation
import RxSwift
import RxCocoa

class DiaryRegistViewController: UIViewController {
    
    private var startPoint : CGPoint?
    private var viewModel: DiaryRegistViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
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
        viewModel = DiaryRegistViewModel(text1: ui.slides[0].text.rx.text.orEmpty.asDriver(),
                                         text2: ui.slides[1].text.rx.text.orEmpty.asDriver(),
                                         text3: ui.slides[2].text.rx.text.orEmpty.asDriver(),
                                         text4: ui.slides[3].text.rx.text.orEmpty.asDriver(),
                                         text5: ui.slides[4].text.rx.text.orEmpty.asDriver(),
                                         text6: ui.slides[5].text.rx.text.orEmpty.asDriver())
        setupViewModel()
    }
}

extension DiaryRegistViewController {
    
    private func setupViewModel() {
        viewModel.isBtnEnable
            .drive(onNext: { [weak self] isEnable in
                guard let this = self else { return }
                this.ui.submitBtn.isHidden = !isEnable
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.isCountEnable
            .distinctUntilChanged()
            .drive(onNext: { [weak self] isCountOver in
                guard let this = self else { return }
                for tuple in this.ui.slides.enumerated() {
                    tuple.element.textCount.textColor = isCountOver[tuple.offset] ? .red : .black
                    if isCountOver[tuple.offset] {
                        AlertController.showAlertMessage(alertType: .overChar, viewController: this)
                        tuple.element.text.setupAnimation()
                    }
                }
            }).disposed(by: viewModel.disposeBag)
        
        #warning("forEachでまとめられると思う")
        ui.slides[0].text.rx.text.asDriver()
            .drive(onNext: { [weak self] text in
                guard let this = self else { return }
                this.ui.slides[0].textCount.text = "15/\(String(describing: text?.count ?? 0))"
            }).disposed(by: viewModel.disposeBag)
        
        ui.slides[1].text.rx.text.asDriver()
            .drive(onNext: { [weak self] text in
                guard let this = self else { return }
                this.ui.slides[1].textCount.text = "200/\(String(describing: text?.count ?? 0))"
            }).disposed(by: viewModel.disposeBag)
        
        ui.slides[2].text.rx.text.asDriver()
            .drive(onNext: { [weak self] text in
                guard let this = self else { return }
                this.ui.slides[2].textCount.text = "200/\(String(describing: text?.count ?? 0))"
            }).disposed(by: viewModel.disposeBag)
        
        ui.slides[3].text.rx.text.asDriver()
            .drive(onNext: { [weak self] text in
                guard let this = self else { return }
                this.ui.slides[3].textCount.text = "200/\(String(describing: text?.count ?? 0))"
            }).disposed(by: viewModel.disposeBag)
        
        ui.slides[4].text.rx.text.asDriver()
            .drive(onNext: { [weak self] text in
                guard let this = self else { return }
                this.ui.slides[4].textCount.text = "200/\(String(describing: text?.count ?? 0))"
            }).disposed(by: viewModel.disposeBag)
        
        ui.slides[5].text.rx.text.asDriver()
            .drive(onNext: { [weak self] text in
                guard let this = self else { return }
                this.ui.slides[5].textCount.text = "200/\(String(describing: text?.count ?? 0))"
            }).disposed(by: viewModel.disposeBag)
        
        ui.eventAddBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.showIndicator()
                this.viewModel.registDiary(text1: this.ui.slides[0].text.text ?? "", text2: this.ui.slides[1].text.text ?? "",
                                           text3: this.ui.slides[2].text.text ?? "", text4: this.ui.slides[3].text.text ?? "",
                                           text5: this.ui.slides[4].text.text ?? "", text6: this.ui.slides[5].text.text ?? "",
                                           stringDate: this.ui.submitDateField.text ?? "", submitted: false, completion: { (_, error) in
                                            if let _ = error {
                                                AlertController.showAlertMessage(alertType: .registDiaryFailure, viewController: this)
                                                this.hideIndicator()
                                                return
                                            }
                                            this.dismiss(animated: true)
                                            this.hideIndicator()
                                            this.viewModel.emptyField(text1: this.ui.slides[0].text, text2: this.ui.slides[1].text,
                                                                      text3: this.ui.slides[2].text, text4: this.ui.slides[3].text,
                                                                      text5: this.ui.slides[4].text, text6: this.ui.slides[5].text)
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.cancelBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.ui.createCancelAlert(vc: this)
            }).disposed(by: viewModel.disposeBag)
        
        ui.submitBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.ui.submitBtn.bounce(completion: {
                    this.showIndicator()
                    this.viewModel.registDiary(text1: this.ui.slides[0].text.text ?? "", text2: this.ui.slides[1].text.text ?? "",
                                               text3: this.ui.slides[2].text.text ?? "", text4: this.ui.slides[3].text.text ?? "",
                                               text5: this.ui.slides[4].text.text ?? "", text6: this.ui.slides[5].text.text ?? "",
                                               stringDate: this.ui.submitDateField.text ?? "", submitted: true, completion: { (_, error) in
                        if let _ = error {
                            AlertController.showAlertMessage(alertType: .registDiaryFailure, viewController: this)
                            this.hideIndicator()
                            return
                        }
                        
                        this.dismiss(animated: true)
                        this.hideIndicator()
                        this.viewModel.emptyField(text1: this.ui.slides[0].text, text2: this.ui.slides[1].text,
                                                  text3: this.ui.slides[2].text, text4: this.ui.slides[3].text,
                                                  text5: this.ui.slides[4].text, text6: this.ui.slides[5].text)
                    })
                })
            }).disposed(by: viewModel.disposeBag)
        
        ui.datePicker.rx.controlEvent(.allEvents)
            .bind { [weak self] _ in
                self?.ui.submitDateField.text = self?.ui.formatter.convertToMonthAndYears(self?.ui.datePicker.date)
            }.disposed(by: viewModel.disposeBag)
        
        ui.diaryScrollView.rx.willBeginDragging
            .bind { [weak self] _ in
                self?.startPoint = UIScrollView().contentOffset
            }.disposed(by: viewModel.disposeBag)
        
        ui.diaryScrollView.rx.didScroll
            .withLatestFrom(self.ui.diaryScrollView.rx.contentOffset)
            .map { Int(round($0.x / UIScreen.main.bounds.width)) }
            .bind(to: ui.pageControl.rx.currentPage)
            .disposed(by: viewModel.disposeBag)
        
        ui.diaryScrollView.rx.didScroll
            .bind { [weak self] _ in
                guard let startPoint = self?.startPoint else { return }
                self?.ui.diaryScrollView.contentOffset.y = startPoint.y
            }.disposed(by: viewModel.disposeBag)
        
        ui.submitDateField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.ui.submitDateField.resignFirstResponder()
            }).disposed(by: viewModel.disposeBag)
        
        ui.viewTapGesture.rx.event
            .bind { [weak self] _ in
                self?.ui.slides.forEach({ view in
                    if view.text.isFirstResponder {
                        view.text.resignFirstResponder()
                    }
                })
            }.disposed(by: viewModel.disposeBag)
    }
}

extension DiaryRegistViewController: IndicatorShowable {}
