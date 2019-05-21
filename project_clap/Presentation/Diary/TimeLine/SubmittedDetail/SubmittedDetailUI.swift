import Foundation
import UIKit

protocol SubmittedDetailUI: UI {
    var diaryScrollView: UIScrollView { get }
    var userInfo: UserInfo { get set }
    var title1: UILabel { get }
    var text1: UITextView { get set }
    var title2: UILabel { get }
    var text2: UITextView { get set }
    var title3: UILabel { get }
    var text3: UITextView { get set }
    var title4: UILabel { get }
    var text4: UITextView { get set }
    var title5: UILabel { get }
    var text5: UITextView { get set }
    var title6: UILabel { get }
    var text6: UITextView { get set }
    var viewTapGesture: UITapGestureRecognizer { get }
    var commentWriteField: UITextField { get }
    var commentTable: UITableView { get }
    
    func setup(vc: UIViewController)
}

final class SubmittedDetailUIImpl: SubmittedDetailUI {
    
    weak var viewController: UIViewController?
    
    private(set) var diaryScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = AppResources.ColorResources.appCommonClearColor
        return scroll
    }()
    
    var userInfo: UserInfo = {
        let view = UserInfo()
        view.backgroundColor = AppResources.ColorResources.appCommonClearColor
        return view
    }()
    
    private(set) var title1: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text1: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()
    
    private(set) var title2: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text2: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()
    
    private(set) var title3: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text3: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()
    
    private(set) var title4: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text4: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()
    
    private(set) var title5: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text5: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()
    
    private(set) var title6: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text6: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    var commentWriteField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.returnKeyType = .send
        field.placeholder = R.string.locarizable.enter_comment()
        return field
    }()
    
    private(set) var commentTable: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = SubmittedDetailResources.View.estimatedRowHeight
        table.rowHeight = UITableView.automaticDimension
        table.register(CommentCell.self, forCellReuseIdentifier: String(describing: CommentCell.self))
        return table
    }()
}

extension SubmittedDetailUIImpl {
    
    func setup(vc: UIViewController) {
        let stack = createDiaryContent()
        let topBottomHeight = vc.view.safeAreaInsets.top + vc.view.safeAreaInsets.bottom + 90
        vc.view.backgroundColor = AppResources.ColorResources.appCommonClearColor
        vc.tabBarController?.tabBar.isHidden = true
        vc.view.addGestureRecognizer(viewTapGesture)
        
        vc.view.addSubview(diaryScrollView)
        [userInfo, stack, commentWriteField, commentTable].forEach { diaryScrollView.addSubview($0) }
        diaryScrollView.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .bottom(to: vc.view.bottomAnchor)
            .width(constant: vc.view.frame.width)
            .activate()
        
        userInfo.anchor()
            .top(to: diaryScrollView.topAnchor)
            .width(constant: vc.view.frame.width)
            .height(constant: SubmittedDetailResources.Constraint.userInfoHeightConstraint)
            .activate()
        
        stack.anchor()
            .centerXToSuperview()
            .top(to: userInfo.bottomAnchor, constant: SubmittedDetailResources.Constraint.stackTopConstraint)
            .width(constant: vc.view.frame.width)
            .activate()
        
        setupDiariesComp(stack: stack)
        
        commentWriteField.anchor()
            .top(to: stack.bottomAnchor, constant: SubmittedDetailResources.Constraint.commentWriteFieldTopConstraint)
            .left(to: diaryScrollView.leftAnchor, constant: SubmittedDetailResources.Constraint.commentWriteFieldLeftConstraint)
            .right(to: diaryScrollView.rightAnchor, constant: SubmittedDetailResources.Constraint.commentWriteFieldRightConstraint)
            .height(constant: SubmittedDetailResources.Constraint.commentWriteFieldHeightConstraint)
            .activate()
        
        commentTable.anchor()
            .top(to: commentWriteField.bottomAnchor, constant: SubmittedDetailResources.Constraint.commentTableTopConstraint)
            .width(constant: vc.view.frame.width)
            .bottom(to: diaryScrollView.bottomAnchor)
            .height(constant: vc.view.frame.height - (SubmittedDetailResources.Constraint.commentWriteFieldHeightConstraint + 20 * 2 + topBottomHeight))
            .activate()
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
