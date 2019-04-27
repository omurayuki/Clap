import Foundation
import UIKit

class commentCell: UITableViewCell {
    
    private var replied = Bool()
    private var viewMovedOverRight = UIView()
    private var commentId = String()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = CommentCellResources.View.userImageLayerCornerRadius
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = CommentCellResources.Font.nameFont
        return label
    }()
    
    private lazy var time: UILabel = {
        let label = UILabel()
        label.font = CommentCellResources.Font.dateFont
        return label
    }()
    
    private lazy var comment: UILabel = {
        let label = UILabel()
        label.numberOfLines = CommentCellResources.View.commentNumberOfLines
        label.font = CommentCellResources.Font.commentFont
        return label
    }()
    
    private lazy var replyCountBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = CommentCellResources.Font.replyCountBtnFont
        button.setTitleColor(.blue, for: .normal)
        button.setTitle(R.string.locarizable.display_reply(), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        if replied == false {
            replyCountBtn.isHidden = true
            viewMovedOverRight.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension commentCell {
    private func setupUI() {
        userImage.backgroundColor = .gray
        addSubview(userImage)
        userImage.anchor()
            .top(to: topAnchor, constant: CommentCellResources.Constraint.userImageLeftConstraint)
            .left(to: leftAnchor, constant: CommentCellResources.Constraint.userImageRightConstraint)
            .width(constant: CommentCellResources.Constraint.userImageWidthConstraint)
            .height(constant: CommentCellResources.Constraint.userImageHeightConstraint)
            .activate()
        
        addSubview(name)
        name.anchor()
            .top(to: topAnchor, constant: CommentCellResources.Constraint.nameTopConstraint)
            .left(to: userImage.rightAnchor, constant: CommentCellResources.Constraint.nameLeftConstraint)
            .activate()
        
        addSubview(time)
        time.anchor()
            .top(to: topAnchor, constant: CommentCellResources.Constraint.dateTopConstraint)
            .left(to: name.rightAnchor)
            .activate()
        
        let stack = createCommentStack()
        addSubview(stack)
        stack.anchor()
            .top(to: name.bottomAnchor, constant: CommentCellResources.Constraint.commentTopConstraint)
            .left(to: userImage.rightAnchor, constant: CommentCellResources.Constraint.commentLeftConstraint)
            .right(to: rightAnchor, constant: CommentCellResources.Constraint.commentBottomConstraint)
            .bottom(to: bottomAnchor, constant: CommentCellResources.Constraint.replyCountBtnBottomConstraint)
            .width(constant: frame.width / 1.2)
            .activate()
    }
    
    func createCommentStack() -> UIStackView {
        let stack = VerticalStackView(arrangeSubViews: [
            comment,
            UIStackView(arrangedSubviews: [
                replyCountBtn,
                viewMovedOverRight
            ])
        ], spacing: 10)
        
        return stack
    }
    
    func configureInit(replied: Bool, image: String, name: String, time: String, comment: String, commentId: String) {
        self.replied = replied
        userImage.image = UIImage(named: image)
        self.name.text = name
        self.time.text = "・\(time)"
        self.comment.text = comment
        self.commentId = commentId
    }
}
