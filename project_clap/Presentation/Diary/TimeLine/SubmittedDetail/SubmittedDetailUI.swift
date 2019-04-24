import Foundation
import UIKit

//// Is it use for component?
//// comment is section, reply is row
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
    var commentWriteField: CustomTextField { get }
    var commentTable: UITableView { get }
    
    func setup(vc: UIViewController)
}

final class SubmittedDetailUIImpl: SubmittedDetailUI {
    
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
        return text
    }()
    
    private(set) var title2: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text2: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title3: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text3: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title4: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text4: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title5: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text5: UITextView = {
        let text = UITextView()
        return text
    }()
    
    private(set) var title6: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var text6: UITextView = {
        let text = UITextView()
        return text
    }()
    
    var commentWriteField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = .white
        field.placeholder = "コメントを入力"
        return field
    }()
    
    private(set) var commentTable: UITableView = {
        let table = UITableView()
        table.rowHeight = 70
        return table
    }()
}

extension SubmittedDetailUIImpl {
    
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = AppResources.ColorResources.appCommonClearColor
        
        vc.view.addSubview(diaryScrollView)
        diaryScrollView.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .bottom(to: vc.view.safeAreaLayoutGuide.bottomAnchor)
            .width(constant: vc.view.frame.width)
            .activate()
        
        diaryScrollView.addSubview(userInfo)
        userInfo.anchor()
            .top(to: diaryScrollView.topAnchor)
            .width(constant: vc.view.frame.width)
            .height(constant: 55)
            .activate()
        
        let stack = createDiaryContent()
        diaryScrollView.addSubview(stack)
        stack.anchor()
            .centerXToSuperview()
            .top(to: userInfo.bottomAnchor, constant: 10)
            .width(constant: vc.view.frame.width)
            .activate()
        
        setupDiariesComp(stack: stack)
        
        diaryScrollView.addSubview(commentWriteField)
        commentWriteField.anchor()
            .top(to: stack.bottomAnchor, constant: 10)
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .height(constant: 35)
            .activate()
        
        diaryScrollView.addSubview(commentTable)
        commentTable.anchor()
            .top(to: commentWriteField.bottomAnchor, constant: 10)
            .width(constant: vc.view.frame.width)
            .bottom(to: diaryScrollView.bottomAnchor)
            .height(constant: 500)
            .activate()
    }
    
    private func createDiaryContent() -> UIStackView {
        
        let stack = VerticalStackView(arrangeSubViews: [
                        VerticalStackView(arrangeSubViews: [
                            title1,
                            text1
                        ], spacing: 5),
                        VerticalStackView(arrangeSubViews: [
                            title2,
                            text2
                        ], spacing: 5),
                        VerticalStackView(arrangeSubViews: [
                            title3,
                            text3
                        ], spacing: 5),
                        VerticalStackView(arrangeSubViews: [
                            title4,
                            text4
                        ], spacing: 5),
                        VerticalStackView(arrangeSubViews: [
                            title5,
                            text5
                        ], spacing: 5),
                        VerticalStackView(arrangeSubViews: [
                            title6,
                            text6
                        ], spacing: 5)
                    ], spacing: 15)
        
        return stack
    }
    
    private func setupDiariesComp(stack: UIStackView) {
        title1.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text1.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: 150)
            .activate()
        
        title2.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text2.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: 150)
            .activate()
        
        title3.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text3.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: 150)
            .activate()
        
        title4.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text4.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: 150)
            .activate()
        
        title5.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text5.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: 150)
            .activate()
        
        title6.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .activate()
        
        text6.anchor()
            .left(to: diaryScrollView.leftAnchor, constant: 15)
            .right(to: diaryScrollView.rightAnchor, constant: 15)
            .width(to: stack.widthAnchor, multiplier: 0.95)
            .height(constant: 150)
            .activate()
    }
}
