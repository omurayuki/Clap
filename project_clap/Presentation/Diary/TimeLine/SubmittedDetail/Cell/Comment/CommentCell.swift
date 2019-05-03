import Foundation
import UIKit
import RxSwift
import RxCocoa

class CommentCell: UITableViewCell {
    
    var viewMovedOverRight = UIView()
    weak var delegate: CommentCellDelegate?
    private var identificationId = Int()
    private var commentId = String()
    private let disposeBag = DisposeBag()
    
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
    
    private lazy var goodBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = CommentCellResources.Font.goodBtnFont
        button.setTitleColor(.black, for: .normal)
        button.setTitle("good", for: .normal)
        return button
    }()
    
    private lazy var badBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = CommentCellResources.Font.badBtnFont
        button.setTitleColor(.black, for: .normal)
        button.setTitle("bad", for: .normal)
        return button
    }()
    
    private lazy var replyBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = CommentCellResources.Font.replyBtnFont
        button.setTitleColor(.black, for: .normal)
        button.setTitle("reply", for: .normal)
        return button
    }()
    
    lazy var replyCountBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = CommentCellResources.Font.replyCountBtnFont
        button.setTitleColor(.blue, for: .normal)
        button.setTitle(R.string.locarizable.display_reply(), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension CommentCell {
    private func setupUI() {
        let stack = createCommentStack()
        userImage.backgroundColor = .gray
        [userImage, name, time, stack].forEach { addSubview($0) }
        
        userImage.anchor()
            .top(to: topAnchor, constant: CommentCellResources.Constraint.userImageLeftConstraint)
            .left(to: leftAnchor, constant: CommentCellResources.Constraint.userImageRightConstraint)
            .width(constant: CommentCellResources.Constraint.userImageWidthConstraint)
            .height(constant: CommentCellResources.Constraint.userImageHeightConstraint)
            .activate()
        
        name.anchor()
            .top(to: topAnchor, constant: CommentCellResources.Constraint.nameTopConstraint)
            .left(to: userImage.rightAnchor, constant: CommentCellResources.Constraint.nameLeftConstraint)
            .activate()
        
        time.anchor()
            .top(to: topAnchor, constant: CommentCellResources.Constraint.dateTopConstraint)
            .left(to: name.rightAnchor)
            .activate()
        
        stack.anchor()
            .top(to: name.bottomAnchor, constant: CommentCellResources.Constraint.commentTopConstraint)
            .left(to: userImage.rightAnchor, constant: CommentCellResources.Constraint.commentLeftConstraint)
            .right(to: rightAnchor, constant: CommentCellResources.Constraint.commentBottomConstraint)
            .bottom(to: bottomAnchor)
            .width(constant: frame.width / 1.2)
            .activate()
    }
    
    private func createCommentStack() -> UIStackView {
        let stack = VerticalStackView(arrangeSubViews: [
            comment,
            EqualingStackView(arrangeSubViews: [
                goodBtn,
                badBtn,
                replyBtn,
                UIView()
            ]),
            UIStackView(arrangedSubviews: [
                replyCountBtn,
                viewMovedOverRight
            ])
        ], spacing: CommentCellResources.View.stackSpacing)
        
        return stack
    }
    
    private func setupRx() {
        replyBtn.rx.tap.asDriver()
            .drive(onNext: {
                self.delegate?.selectReplyBtn(index: self.identificationId)
            }).disposed(by: disposeBag)
        
        replyCountBtn.rx.tap.asDriver()
            .drive(onNext: {
                self.delegate?.selectDoingReplyBtn(index: self.identificationId)
            }).disposed(by: disposeBag)
    }
    
    func configureInit(image: String, name: String, time: String, comment: String, commentId: String, identificationId: Int) {
        userImage.image = UIImage(named: image)
        self.name.text = name
        self.time.text = "・\(time)"
        self.comment.text = comment
        self.commentId = commentId
        self.identificationId = identificationId
    }
}
