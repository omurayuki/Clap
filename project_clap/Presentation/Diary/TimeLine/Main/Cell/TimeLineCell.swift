import Foundation
import UIKit

class TimelineCell: UITableViewCell {
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = TimeLineResources.View.imageCornerRadius
        return imageView
    }()

    private lazy var diaryTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = TimeLineResources.Font.diaryTitleFont
        return label
    }()

    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = TimeLineResources.Font.userNameFont
        return label
    }()

    private lazy var submittedTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = TimeLineResources.Font.submittedTimeFont
        return label
    }()
    
    private lazy var wrapView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = DisplayCalendarResources.View.wrapViewLayerCornerRadius
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension TimelineCell {
    private func setupUI() {
        contentView.backgroundColor = AppResources.ColorResources.appCommonClearColor
        contentView.addSubview(userImage)
        userImage.anchor()
            .centerYToSuperview()
            .left(to: contentView.leftAnchor, constant: TimeLineResources.Constraint.userImageLeftConstraint)
            .activate()
        userImage.constrainWidth(constant: TimeLineResources.Constraint.userImageWidthConstraint)
        userImage.constrainHeight(constant: TimeLineResources.Constraint.userImageHeightConstraint)
        
        contentView.addSubview(diaryTitle)
        diaryTitle.anchor()
            .top(to: contentView.topAnchor, constant: TimeLineResources.Constraint.diaryTitleTopConstraint)
            .left(to: userImage.rightAnchor, constant: TimeLineResources.Constraint.diaryTitleLeftConstraint)
            .width(constant: 250)
            .activate()
        
        contentView.addSubview(userName)
        userName.anchor()
            .top(to: diaryTitle.bottomAnchor, constant: TimeLineResources.Constraint.userNameTopConstraint)
            .left(to: userImage.rightAnchor, constant: TimeLineResources.Constraint.userNameLeftConstraint)
            .activate()
        
        contentView.addSubview(submittedTime)
        submittedTime.anchor()
            .top(to: diaryTitle.bottomAnchor, constant: TimeLineResources.Constraint.submitTimeTopConstraint)
            .right(to: contentView.rightAnchor, constant: TimeLineResources.Constraint.submitTimeRightConstraint)
            .activate()
    }
    
    func configureInit(image: String, title: String, name: String, time: String) {
        userImage.image = UIImage(named: image)
        diaryTitle.text = title
        userName.text = name
        submittedTime.text = time
    }
}
