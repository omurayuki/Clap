import UIKit

class TimeLineCell: UICollectionViewCell {
    
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
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension TimeLineCell {
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            userImage,
            diaryTitle,
            VerticalStackView(arrangeSubViews: [
                userName,
                submittedTime
                ], spacing: 10)
            ])
        addSubview(stackView)
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.fillSuperview()
        userImage.constrainWidth(constant: 45)
        userImage.constrainHeight(constant: 45)
        
        addSubview(separatorView)
        separatorView.anchor(top: nil,
                             leading: diaryTitle.leadingAnchor,
                             bottom: bottomAnchor, trailing: trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: -4, right: 0),
                             size: .init(width: 0, height: 0.5))
    }
}
