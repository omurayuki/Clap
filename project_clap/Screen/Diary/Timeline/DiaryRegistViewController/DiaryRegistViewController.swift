import Foundation
import UIKit
import RxSwift
import RxCocoa
import PopupDialog

class DiaryRegistViewController: UIViewController {
    
    private var slides: [DiaryView]!
    var startPoint : CGPoint!
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
    
    private lazy var eventAddBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.check(), style: .plain, target: self, action: #selector(registEvent))
        return button
    }()
    
    private lazy var cancelBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.batsu(), style: .plain, target: self, action: #selector(cancelEvent))
        return button
    }()
    
    private lazy var registDiaryNavItem: UINavigationItem = {
        let nav = UINavigationItem()
        nav.leftBarButtonItem = cancelBtn
        nav.rightBarButtonItem = eventAddBtn
        return nav
    }()
    
    private lazy var registDiaryBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.barTintColor = .white
        bar.pushItem(registDiaryNavItem, animated: true)
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        dp.addTarget(self, action: #selector(changeSubmitDate), for: .valueChanged)
        return dp
    }()
    
    private lazy var submitDateField: UITextField = {
        let field = UITextField()
        field.text = formatter.string(from: Date())
        field.textAlignment = .center
        field.backgroundColor = .white
        field.layer.cornerRadius = DiaryRegistResouces.View.submitDateFieldLayerCornerRadius
        field.layer.borderWidth = DiaryRegistResouces.View.submitDateFieldBorderWidth
        field.layer.borderColor = UIColor.gray.cgColor
        field.tintColor = .clear
        field.inputView = datePicker
        field.font = RegistCalendarResources.Font.defaultDateFont
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var diaryScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .gray
        scroll.isScrollEnabled = true
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = AppResources.ColorResources.shallowBlueColor
        control.currentPage = DiaryRegistResouces.View.currentPageNum
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.diary_submit(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = DiaryRegistResouces.View.submitBtnLayerCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
    }
}

extension DiaryRegistViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(registDiaryBar)
        registDiaryBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        registDiaryBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        registDiaryBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        view.addSubview(submitDateField)
        submitDateField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitDateField.topAnchor.constraint(equalTo: registDiaryBar.bottomAnchor, constant: DiaryRegistResouces.Constraint.submitDateFieldTopConstraint).isActive = true
        submitDateField.widthAnchor.constraint(equalToConstant: DiaryRegistResouces.Constraint.submitDateFieldWidthConstraint).isActive = true
        submitDateField.heightAnchor.constraint(equalToConstant: DiaryRegistResouces.Constraint.submitDateFieldHeightConstraint).isActive = true
        view.addSubview(diaryScrollView)
        diaryScrollView.topAnchor.constraint(equalTo: submitDateField.bottomAnchor).isActive = true
        diaryScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        diaryScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        diaryScrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 1.8).isActive = true
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: diaryScrollView.bottomAnchor, constant: DiaryRegistResouces.Constraint.pageControlTopConstraint).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.5).isActive = true
        view.addSubview(submitBtn)
        submitBtn.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: DiaryRegistResouces.Constraint.submitBtnTopConstraint).isActive = true
        submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func createCancelAlert() {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.lost_written_info())
        let logout = DefaultButton(title: R.string.locarizable.yes()) { self.dismiss(animated: true) }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) {}
        alert.addButtons([logout, cancel])
        self.present(alert, animated: true)
    }
    
    private func createSlides() -> [DiaryView] {
        guard let slide1: DiaryView = Bundle.main.loadNibNamed("DiaryView", owner: self, options: nil)?.first as? DiaryView else { return [DiaryView()] }
        guard let slide2: DiaryView = Bundle.main.loadNibNamed("DiaryView", owner: self, options: nil)?.first as? DiaryView else { return [DiaryView()] }
        guard let slide3: DiaryView = Bundle.main.loadNibNamed("DiaryView", owner: self, options: nil)?.first as? DiaryView else { return [DiaryView()] }
        guard let slide4: DiaryView = Bundle.main.loadNibNamed("DiaryView", owner: self, options: nil)?.first as? DiaryView else { return [DiaryView()] }
        guard let slide5: DiaryView = Bundle.main.loadNibNamed("DiaryView", owner: self, options: nil)?.first as? DiaryView else { return [DiaryView()] }
        guard let slide6: DiaryView = Bundle.main.loadNibNamed("DiaryView", owner: self, options: nil)?.first as? DiaryView else { return [DiaryView()] }
        return [slide1, slide2, slide3, slide4, slide5, slide6]
    }
    
    private func setupSlideScrollView(slides: [DiaryView]) {
        pageControl.numberOfPages = slides.count
        diaryScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        diaryScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        for slide in 0 ..< slides.count {
            slides[slide].frame = CGRect(x: view.frame.width * CGFloat(slide), y: 0, width: view.frame.width, height: view.frame.height)
            diaryScrollView.addSubview(slides[slide])
        }
    }
    
    @objc
    private func registEvent() {
        
    }
    
    @objc
    private func cancelEvent() {
        createCancelAlert()
    }
    
    @objc
    private func changeSubmitDate() {
        submitDateField.text = formatter.convertToMonthAndYears(datePicker.date)
    }
}

extension DiaryRegistViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension DiaryRegistViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startPoint = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = startPoint.y
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
