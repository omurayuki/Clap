import Foundation
import UIKit
import PopupDialog

protocol DiaryRegistUI: UI {
    var slides: [DiaryView] { get set }
    var viewTapGesture: UITapGestureRecognizer { get }
    var formatter: DateFormatter { get }
    var eventAddBtn: UIBarButtonItem { get set }
    var cancelBtn: UIBarButtonItem { get set }
    var registDiaryNavItem: UINavigationItem { get }
    var registDiaryBar: UINavigationBar { get }
    var datePicker: UIDatePicker { get }
    var submitDateField: UITextField { get }
    var diaryScrollView: UIScrollView { get }
    var pageControl: UIPageControl { get }
    var submitBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func createCancelAlert(vc: UIViewController)
    func createSlides(vc: UIViewController, slides: Int) -> [DiaryView]
    func setupSlideScrollView(slides: [DiaryView], vc: UIViewController)
}

final class DiaryRegistUIImpl: DiaryRegistUI {
    
    var viewController: UIViewController?
    
    var slides: [DiaryView] = []
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    private(set) var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
    
    var eventAddBtn: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = R.string.locarizable.draft()
        button.style = .plain
        return button
    }()
    
    var cancelBtn: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = R.string.locarizable.batsu()
        button.style = .plain
        return button
    }()
    
    private(set) var registDiaryNavItem: UINavigationItem = {
        let nav = UINavigationItem()
        return nav
    }()
    
    private(set) var registDiaryBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.barTintColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private(set) var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.timeZone = NSTimeZone.local
        dp.locale = .current
        return dp
    }()
    
    private(set) var submitDateField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.backgroundColor = .white
        field.layer.cornerRadius = DiaryRegistResouces.View.submitDateFieldLayerCornerRadius
        field.layer.borderWidth = DiaryRegistResouces.View.submitDateFieldBorderWidth
        field.layer.borderColor = UIColor.gray.cgColor
        field.tintColor = .clear
        field.font = RegistCalendarResources.Font.defaultDateFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var diaryScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .gray
        scroll.isScrollEnabled = true
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private(set) var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = AppResources.ColorResources.shallowBlueColor
        control.currentPage = DiaryRegistResouces.View.currentPageNum
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private(set) var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.diary_submit(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = DiaryRegistResouces.View.submitBtnLayerCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension DiaryRegistUIImpl {
    
    func setup(vc: UIViewController) {
        registDiaryNavItem.leftBarButtonItem = cancelBtn
        registDiaryNavItem.rightBarButtonItem = eventAddBtn
        registDiaryBar.pushItem(registDiaryNavItem, animated: true)
        submitDateField.text = formatter.string(from: Date())
        submitDateField.inputView = datePicker
        vc.view.backgroundColor = .white
        vc.view.addGestureRecognizer(viewTapGesture)
        [registDiaryBar, submitDateField, diaryScrollView, pageControl, submitBtn].forEach { vc.view.addSubview($0) }
        
        registDiaryBar.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .left(to: vc.view.leftAnchor)
            .right(to: vc.view.rightAnchor)
            .activate()
        
        submitDateField.anchor()
            .centerXToSuperview()
            .top(to: registDiaryBar.bottomAnchor, constant: DiaryRegistResouces.Constraint.submitDateFieldTopConstraint)
            .width(constant: DiaryRegistResouces.Constraint.submitDateFieldWidthConstraint)
            .height(constant: DiaryRegistResouces.Constraint.submitDateFieldHeightConstraint)
            .activate()
        
        diaryScrollView.anchor()
            .top(to: submitDateField.bottomAnchor)
            .left(to: vc.view.leftAnchor)
            .right(to: vc.view.rightAnchor)
            .height(constant: vc.view.frame.size.height / 1.8)
            .activate()
        
        pageControl.anchor()
            .centerXToSuperview()
            .top(to: diaryScrollView.bottomAnchor, constant: DiaryRegistResouces.Constraint.pageControlTopConstraint)
            .width(constant: vc.view.frame.size.width / 1.5)
            .activate()
        
        submitBtn.anchor()
            .centerXToSuperview()
            .top(to: pageControl.bottomAnchor, constant: DiaryRegistResouces.Constraint.submitBtnTopConstraint)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
    
    func createCancelAlert(vc: UIViewController) {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.lost_written_info())
        let logout = DefaultButton(title: R.string.locarizable.yes()) { vc.dismiss(animated: true) }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) {}
        alert.addButtons([logout, cancel])
        vc.present(alert, animated: true)
    }
    
    func createSlides(vc: UIViewController, slides: Int) -> [DiaryView] {
        var returningSlide = [DiaryView]()
        for _ in 0 ..< slides {
            guard let slide = Bundle.main.loadNibNamed("DiaryView", owner: vc, options: nil)?.first as? DiaryView else { return [DiaryView()] }
            returningSlide.append(slide)
        }
        return returningSlide
    }
    
    func setupSlideScrollView(slides: [DiaryView], vc: UIViewController) {
        pageControl.numberOfPages = slides.count
        diaryScrollView.frame = CGRect(x: 0, y: 0, width: vc.view.frame.width, height: vc.view.frame.height)
        diaryScrollView.contentSize = CGSize(width: vc.view.frame.width * CGFloat(slides.count), height: vc.view.frame.height)
        for slide in 0 ..< slides.count {
            slides[slide].frame = CGRect(x: vc.view.frame.width * CGFloat(slide), y: 0, width: vc.view.frame.width, height: vc.view.frame.height)
            diaryScrollView.addSubview(slides[slide])
        }
    }
}
