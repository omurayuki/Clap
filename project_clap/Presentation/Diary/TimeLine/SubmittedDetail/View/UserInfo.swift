import Foundation
import UIKit

class UserInfo: UIView {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 18
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension UserInfo {
    private func setupUI() {
        addSubview(image)
        image.anchor()
            .centerYToSuperview()
            .left(to: leftAnchor, constant: 10)
            .width(constant: 36)
            .height(constant: 36)
            .activate()
        
        let stack = createStack()
        addSubview(stack)
        stack.anchor()
            .centerYToSuperview()
            .left(to: image.rightAnchor, constant: 10)
            .activate()
    }
    
    func createStack() -> UIStackView {
        let stack = VerticalStackView(arrangeSubViews: [
            name,
            date
        ], spacing: 10)
        return stack
    }
    
    func configureInit(image: String, name: String, date: Date) {
        self.image.image = UIImage(named: image)
        self.name.text = name
        self.date.text = DateFormatter().convertToMonthAndYears(date)
    }
}
