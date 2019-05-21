import Foundation
import UIKit

protocol ReplyUI: UI {
    var navigationBar: UINavigationBar { get }
    var navigationItem: UINavigationItem { get }
    var cancelBtn: UIBarButtonItem { get }
    var userImage: UIImageView { get }
    var name: UILabel { get }
    var time: UILabel { get }
    var comment: UILabel { get }
    var replyWriteField: UITextField { get }
    var replyTable: UITableView { get }
    
    func setupUI(userImage: String, name: String, time: String, comment: String)
}

final class ReplyUIImpl: ReplyUI {
    
    weak var viewController: UIViewController?
    
    private(set) var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.barTintColor = .white
        return bar
    }()
    
    private(set) var navigationItem: UINavigationItem = {
        let navi = UINavigationItem()
        return navi
    }()
    
    private(set) var cancelBtn: UIBarButtonItem = {
        let item = UIBarButtonItem(title: R.string.locarizable.batsu(), style: .plain, target: nil, action: nil)
        return item
    }()
    
    private(set) var userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = ReplyResources.View.userImageLayerCornerRadius
        return image
    }()
    
    private(set) var name: UILabel = {
        let label = UILabel()
        label.font = ReplyResources.Font.nameFont
        return label
    }()
    
    private(set) var time: UILabel = {
        let label = UILabel()
        label.font = ReplyResources.Font.dateFont
        return label
    }()
    
    private(set) var comment: UILabel = {
        let label = UILabel()
        label.numberOfLines = ReplyResources.View.commentNumberOfLines
        label.font = ReplyResources.Font.commentFont
        return label
    }()
    
    var replyWriteField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.returnKeyType = .send
        field.placeholder = R.string.locarizable.enter_comment()
        return field
    }()
    
    private(set) var replyTable: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = ReplyResources.View.estimatedRowHeight
        table.rowHeight = UITableView.automaticDimension
        table.register(ReplyCell.self, forCellReuseIdentifier: String(describing: ReplyCell.self))
        return table
    }()
}

extension ReplyUIImpl {
    func setupUI(userImage: String, name: String, time: String, comment: String) {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = AppResources.ColorResources.appCommonClearColor
        self.userImage.backgroundColor = .gray
        self.userImage.image = UIImage(named: userImage)
        self.name.text = name
        self.time.text = "・\(time)"
        self.comment.text = comment
        navigationItem.leftBarButtonItem = cancelBtn
        navigationBar.pushItem(navigationItem, animated: true)
        [navigationBar, self.userImage,
         self.name, self.time,
         self.comment, replyWriteField, replyTable].forEach { vc.view.addSubview($0) }
        
        navigationBar.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .width(constant: vc.view.frame.width)
            .activate()
        
        self.userImage.anchor()
            .top(to: navigationBar.bottomAnchor, constant: ReplyResources.Constraint.userImageTopConstraint)
            .left(to: vc.view.leftAnchor, constant: ReplyResources.Constraint.userImageLeftConstraint)
            .width(constant: ReplyResources.Constraint.userImageWidthConstraint)
            .height(constant: ReplyResources.Constraint.userImageHeightConstraint)
            .activate()
        
        self.name.anchor()
            .top(to: navigationBar.bottomAnchor, constant: ReplyResources.Constraint.nameTopConstraint)
            .left(to: self.userImage.rightAnchor, constant: ReplyResources.Constraint.nameLeftConstraint)
            .activate()
        
        self.time.anchor()
            .top(to: navigationBar.bottomAnchor, constant: ReplyResources.Constraint.timeTopConstraint)
            .left(to: self.name.rightAnchor)
            .activate()
        
        self.comment.anchor()
            .top(to: self.name.bottomAnchor, constant: ReplyResources.Constraint.commentTopConstraint)
            .left(to: self.userImage.rightAnchor, constant: ReplyResources.Constraint.commentLeftConstraint)
            .right(to: vc.view.rightAnchor, constant: ReplyResources.Constraint.commentRightConstraint)
            .activate()
        
        replyWriteField.anchor()
            .top(to: self.comment.bottomAnchor, constant: ReplyResources.Constraint.replyWriteFieldTopConstraint)
            .left(to: vc.view.leftAnchor, constant: ReplyResources.Constraint.replyWriteFieldLeftConstraint)
            .right(to: vc.view.rightAnchor, constant: ReplyResources.Constraint.replyWriteFieldRightConstraint)
            .height(constant: ReplyResources.Constraint.replyWriteFieldHeightConstraint)
            .activate()
        
        replyTable.anchor()
            .top(to: replyWriteField.bottomAnchor, constant: ReplyResources.Constraint.replyTableTopConstraint)
            .width(constant: vc.view.frame.width)
            .bottom(to: vc.view.bottomAnchor)
            .height(constant: vc.view.frame.height)
            .activate()
    }
}
