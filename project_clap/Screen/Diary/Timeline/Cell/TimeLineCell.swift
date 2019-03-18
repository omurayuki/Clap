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
        wrapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: TimeLineResources.Constraint.wrapViewTopConstraint).isActive = true
        wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: TimeLineResources.Constraint.wrapViewBottomConstraint).isActive = true
        wrapView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: TimeLineResources.Constraint.wrapViewLeftConstraint).isActive = true
        wrapView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: TimeLineResources.Constraint.wrapViewRightConstraint).isActive = true
        setupInsideWrapView()
    }
    
    private func setupInsideWrapView() {
        wrapView.addSubview(userImage)
        userImage.centerYAnchor.constraint(equalTo: wrapView.centerYAnchor).isActive = true
        userImage.leftAnchor.constraint(equalTo: wrapView.leftAnchor, constant: TimeLineResources.Constraint.userImageLeftConstraint).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: TimeLineResources.Constraint.userImageWidthConstraint).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: TimeLineResources.Constraint.userImageHeightConstraint).isActive = true
        wrapView.addSubview(diaryTitle)
        diaryTitle.centerYAnchor.constraint(equalTo: wrapView.centerYAnchor).isActive = true
        diaryTitle.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: TimeLineResources.Constraint.diaryTitleLeftConstraint).isActive = true
        wrapView.addSubview(userName)
        userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: TimeLineResources.Constraint.userNameLeftConstraint).isActive = true
        userName.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: TimeLineResources.Constraint.userNameBottomConstraint).isActive = true
        wrapView.addSubview(submitTime)
        submitTime.rightAnchor.constraint(equalTo: wrapView.rightAnchor, constant: TimeLineResources.Constraint.submitTimeRightConstraint).isActive = true
        submitTime.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: TimeLineResources.Constraint.submitTimeBottomConstraint).isActive = true
    }
    
    func configureInit(image: UIImage, name: String, title: String, time: String) {
        userImage.image = image
        userName.text = name
        diaryTitle.text = title
        submitTime.text = time
    }
}
