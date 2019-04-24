import UIKit

protocol DraftDetailUI: UI {
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
    
    func setup(vc: UIViewController)
}

final class DraftDetailUIImpl: DraftDetailUI {
    
    var viewController: UIViewController?
    
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
}

extension DraftDetailUIImpl {
    
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = AppResources.ColorResources.appCommonClearColor
        
        vc.view.addSubview(diaryScrollView)
        diaryScrollView.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .bottom(to: vc.view.safeAreaLayoutGuide.bottomAnchor)
            .width(constant: vc.view.frame.width)
            .activate()
        
        let stack = createDiaryContent()
        diaryScrollView.addSubview(stack)
        stack.anchor()
            .centerXToSuperview()
            .top(to: diaryScrollView.topAnchor, constant: SubmittedDetailResources.Constraint.stackTopConstraint)
            .width(constant: vc.view.frame.width)
            .activate()
        
        setupDiariesComp(stack: stack)
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
                ], spacing: SubmittedDetailResources.Constraint.stackContentsSpacing)
            ], spacing: SubmittedDetailResources.Constraint.stackSpacing)
        
        return stack
    }
    
    private func setupDiariesComp(stack: UIStackView) {
        title1.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text1.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title2.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text2.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title3.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text3.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title4.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text4.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title5.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text5.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
        
        title6.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text6.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.stackLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.stackRightConstraint)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: SubmittedDetailResources.Constraint.textHeightConstraint)
            .activate()
    }
}
