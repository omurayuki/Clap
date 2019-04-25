import Foundation
import UIKit

class commentCell: UITableViewCell {
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var comment: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var replyCountBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("返信を表示する", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
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
            .top(to: topAnchor, constant: 20)
            .left(to: leftAnchor, constant: 20)
            .width(constant: 40)
            .height(constant: 40)
            .activate()
        
        addSubview(name)
        name.anchor()
            .top(to: topAnchor, constant: 20)
            .left(to: userImage.rightAnchor, constant: 20)
            .activate()
        
        addSubview(date)
        date.anchor()
            .top(to: topAnchor, constant: 20)
            .left(to: name.rightAnchor)
            .activate()
        
        addSubview(comment)
        comment.anchor()
            .top(to: name.bottomAnchor, constant: 20)
            .left(to: userImage.rightAnchor, constant: 20)
            .right(to: rightAnchor,constant: -20)
            .width(constant: frame.width / 1.2)
            .activate()
        
        addSubview(replyCountBtn)
        replyCountBtn.anchor()
            .top(to: comment.bottomAnchor, constant: 20)
            .left(to: userImage.rightAnchor, constant: 20)
            .bottom(greaterOrEqual: bottomAnchor, constant: 20)
            .activate()
    }
    
    func configureInit(image: String, name: String, date: String, comment: String) {
        userImage.image = UIImage(named: image)
        self.name.text = name
        self.date.text = "・\(date)"
        self.comment.text = comment
    }
}
