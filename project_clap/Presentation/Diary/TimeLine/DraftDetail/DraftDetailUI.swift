import UIKit

protocol DraftDetailUI: UI {
    var viewTapGesture: UITapGestureRecognizer { get }
    var formatter: DateFormatter { get }
    var datePicker: UIDatePicker { get }
    var submitDateField: UITextField { get }
    var diaryScrollView: UIScrollView { get }
    var title1: UILabel { get }
    var text1: UITextView { get }
    var title2: UILabel { get }
    var text2: UITextView { get }
    var title3: UILabel { get }
    var text3: UITextView { get }
    var title4: UILabel { get }
    var text4: UITextView { get }
    var title5: UILabel { get }
    var text5: UITextView { get }
    var title6: UILabel { get }
    var text6: UITextView { get }
    var submitBtn: UIButton { get }
    var draftBtn: UIButton { get }
    
    func setup(vc: UIViewController)
}

final class DraftDetailUIImpl: DraftDetailUI {
    
    weak var viewController: UIViewController?
    
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
        return field
    }()
    
    private(set) var diaryScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = AppResources.ColorResources.appCommonClearColor
        return scroll
    }()
    
    private(set) var title1: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private(set) var text1: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title2: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private(set) var text2: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title3: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private(set) var text3: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title4: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private(set) var text4: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title5: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private(set) var text5: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title6: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private(set) var text6: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.diary_submit(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = DiaryRegistResouces.View.submitBtnLayerCornerRadius
        return button
    }()
    
    private(set) var draftBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.draft(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = DiaryRegistResouces.View.submitBtnLayerCornerRadius
        return button
    }()
}

extension DraftDetailUIImpl {
    
    func setup(vc: UIViewController) {
        submitDateField.inputView = datePicker
        vc.view.backgroundColor = AppResources.ColorResources.appCommonClearColor
        vc.tabBarController?.tabBar.isHidden = true
        
        vc.view.addGestureRecognizer(viewTapGesture)
        [diaryScrollView, submitDateField].forEach { vc.view.addSubview($0) }
        
        submitDateField.anchor()
            .centerXToSuperview()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor, constant: DiaryRegistResouces.Constraint.submitDateFieldTopConstraint)
            .width(constant: DiaryRegistResouces.Constraint.submitDateFieldWidthConstraint)
            .height(constant: DiaryRegistResouces.Constraint.submitDateFieldHeightConstraint)
            .activate()
        
        diaryScrollView.anchor()
            .top(to: submitDateField.bottomAnchor, constant: 20)
            .bottom(to: vc.view.safeAreaLayoutGuide.bottomAnchor)
            .width(constant: vc.view.frame.width)
            .activate()
        
        let stack = createDiaryContent()
        [stack].forEach { diaryScrollView.addSubview($0) }
        stack.anchor()
            .top(to: diaryScrollView.topAnchor, constant: SubmittedDetailResources.Constraint.stackTopConstraint)
            .right(to: vc.view.rightAnchor, constant: -10)
            .left(to: vc.view.leftAnchor, constant: 10)
            .bottom(to: diaryScrollView.bottomAnchor, constant: -10)
            .width(constant: vc.view.frame.width)
            .activate()
        
        setupDiariesComp(stack: stack, vc: vc)
    }
    
    private func createDiaryContent() -> UIStackView {
        
        let stack = VerticalStackView(arrangeSubViews: [
            VerticalStackView(arrangeSubViews: [
                title1,
                text1
            ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing),
            VerticalStackView(arrangeSubViews: [
                title2,
                text2
            ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing),
            VerticalStackView(arrangeSubViews: [
                title3,
                text3
            ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing),
            VerticalStackView(arrangeSubViews: [
                title4,
                text4
            ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing),
            VerticalStackView(arrangeSubViews: [
                title5,
                text5
            ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing),
            VerticalStackView(arrangeSubViews: [
                title6,
                text6
            ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing),
            submitBtn,
            draftBtn
        ], spacing: SubmittedDetailResources.Constraint.stackSpacing)
        
        return stack
    }
    
    private func setupDiariesComp(stack: UIStackView, vc: UIViewController) {
        title1.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .activate()
        
        text1.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title2.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .activate()
        
        text2.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title3.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .activate()
        
        text3.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title4.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .activate()
        
        text4.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title5.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .activate()
        
        text5.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title6.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .activate()
        
        text6.anchor()
            .left(to: diaryScrollView.leftAnchor)
            .right(to: diaryScrollView.rightAnchor)
            .width(to: stack.widthAnchor)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
    }
}
