import Foundation
import UIKit

class TimeLineCell: UITableViewCell {
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = TimeLineResources.View.userImageLayerConrnerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.font = TimeLineResources.Font.userNameFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var diaryTitle: UILabel = {
        let label = UILabel()
        label.font = TimeLineResources.Font.diaryTitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var submitTime: UILabel = {
        let label = UILabel()
        label.font = TimeLineResources.Font.submitTimeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wrapView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = TimeLineResources.View.wrapViewLayerCornerRadius
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimeLineCell {
    private func setupUI() {
        contentView.backgroundColor = AppResources.ColorResources.appCommonClearColor
        contentView.addSubview(wrapView)
        wrapView.anchor()
            .top(to: contentView.topAnchor, constant: TimeLineResources.Constraint.wrapViewTopConstraint)
            .bottom(to: contentView.bottomAnchor, constant: TimeLineResources.Constraint.wrapViewBottomConstraint)
            .left(to: contentView.leftAnchor, constant: TimeLineResources.Constraint.wrapViewLeftConstraint)
            .right(to: contentView.rightAnchor, constant: TimeLineResources.Constraint.wrapViewRightConstraint)
            .activate()
        setupInsideWrapView()
    }
    
    private func setupInsideWrapView() {
        wrapView.addSubview(userImage)
        wrapView.addSubview(diaryTitle)
        wrapView.addSubview(userName)
        wrapView.addSubview(submitTime)
        
        userImage.anchor()
            .centerYToSuperview()
            .left(to: wrapView.leftAnchor, constant: TimeLineResources.Constraint.userImageLeftConstraint)
            .width(constant: TimeLineResources.Constraint.userImageWidthConstraint)
            .height(constant: TimeLineResources.Constraint.userImageHeightConstraint)
            .activate()
        
        diaryTitle.anchor()
            .centerYToSuperview()
            .left(to: userImage.rightAnchor, constant: TimeLineResources.Constraint.diaryTitleLeftConstraint)
            .activate()
        
        userName.anchor()
            .left(to: userImage.rightAnchor, constant: TimeLineResources.Constraint.userNameLeftConstraint)
            .bottom(to: wrapView.bottomAnchor, constant: TimeLineResources.Constraint.userNameBottomConstraint)
            .activate()
        
        submitTime.anchor()
            .right(to: wrapView.rightAnchor, constant: TimeLineResources.Constraint.submitTimeRightConstraint)
            .bottom(to: wrapView.bottomAnchor, constant: TimeLineResources.Constraint.submitTimeBottomConstraint)
            .activate()
    }
    
    func configureInit(image: UIImage?, name: String, title: String, time: String) {
        userImage.image = image
        userName.text = name
        diaryTitle.text = title
        submitTime.text = time
    }
}
