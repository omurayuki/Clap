import Foundation
import UIKit

class TimelineCell: UITableViewCell {
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 22.5
        return imageView
    }()

    private lazy var diaryTitle: UILabel = {
        let label = UILabel()
        label.text = "hoeghogehogehoge"
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "小村 祐輝"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private lazy var submittedTime: UILabel = {
        let label = UILabel()
        label.text = "12月12日"
        label.font = .systemFont(ofSize: 12)
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
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimelineCell {
    private func setupUI() {
        contentView.backgroundColor = AppResources.ColorResources.appCommonClearColor
        contentView.addSubview(wrapView)
        wrapView.anchor()
            .top(to: contentView.topAnchor, constant: DisplayCalendarResources.Constraint.wrapViewTopConstraint)
            .left(to: contentView.leftAnchor, constant: DisplayCalendarResources.Constraint.wrapViewLeftConstraint)
            .bottom(to: contentView.bottomAnchor, constant: DisplayCalendarResources.Constraint.wrapViewBottomConstraint)
            .right(to: contentView.rightAnchor, constant: DisplayCalendarResources.Constraint.wrapViewRightConstraint)
            .activate()
        
        setupInsideWrapView()
    }
    
    private func setupInsideWrapView() {
        wrapView.addSubview(userImage)
        wrapView.addSubview(diaryTitle)
        wrapView.addSubview(userName)
        wrapView.addSubview(submittedTime)
        
        let stackView = UIStackView(arrangedSubviews: [
            userImage,
            diaryTitle,
            VerticalStackView(arrangeSubViews: [
                userName,
                submittedTime
                ], spacing: 10)
            ])
        wrapView.addSubview(stackView)
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.fillSuperview()
        userImage.constrainWidth(constant: 45)
        userImage.constrainHeight(constant: 45)
    }
    
    func configureInit(image: String, title: String, name: String, time: String) {
        userImage.image = UIImage(named: image)
        diaryTitle.text = title
        userName.text = name
        submittedTime.text = time
    }
}
