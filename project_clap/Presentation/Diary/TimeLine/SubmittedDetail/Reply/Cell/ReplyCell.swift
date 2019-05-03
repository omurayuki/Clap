import Foundation
import UIKit

class ReplyCell: UITableViewCell {
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = ReplyCellResources.View.userImageLayerCornerRadius
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = ReplyCellResources.Font.nameFont
        return label
    }()
    
    private lazy var time: UILabel = {
        let label = UILabel()
        label.font = ReplyCellResources.Font.dateFont
        return label
    }()
    
    private lazy var reply: UILabel = {
        let label = UILabel()
        label.numberOfLines = ReplyCellResources.View.replyNumberOfLines
        label.font = ReplyCellResources.Font.replyFont
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension ReplyCell {
    func setupUI() {
        userImage.backgroundColor = .gray
        [userImage, name, time, reply].forEach { addSubview($0) }
        
        userImage.anchor()
            .top(to: topAnchor, constant: ReplyCellResources.Constraint.userImageTopConstraint)
            .left(to: leftAnchor, constant: ReplyCellResources.Constraint.userImageLeftConstraint)
            .width(constant: ReplyCellResources.Constraint.userImageWidthConstraint)
            .height(constant: ReplyCellResources.Constraint.userImageHeightConstraint)
            .activate()
        
        name.anchor()
            .top(to: topAnchor, constant: ReplyCellResources.Constraint.nameTopConstraint)
            .left(to: userImage.rightAnchor, constant: ReplyCellResources.Constraint.nameLeftConstraint)
            .activate()
        
        time.anchor()
            .top(to: topAnchor, constant: ReplyCellResources.Constraint.timeTopConstraint)
            .left(to: name.rightAnchor)
            .activate()
        
        reply.anchor()
            .top(to: name.bottomAnchor, constant: ReplyCellResources.Constraint.replyTopConstraint)
            .left(to: userImage.rightAnchor, constant: ReplyCellResources.Constraint.replyLeftConstraint)
            .right(to: rightAnchor, constant: ReplyCellResources.Constraint.replyRightConstraint)
            .bottom(to: bottomAnchor, constant: ReplyCellResources.Constraint.replyBottomConstraint)
            .width(constant: frame.width / 1.2)
            .activate()
    }
    
    func configureInit(image: String, name: String, time: String, reply: String) {
        userImage.image = UIImage(named: image)
        self.name.text = name
        self.time.text = "・\(time)"
        self.reply.text = reply
    }
}
