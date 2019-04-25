import Foundation
import UIKit

class UserInfo: UIView {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UserInfoResources.View.imageCornerLayerRadius
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UserInfoResources.Font.nameFont
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UserInfoResources.Font.dateFont
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
            .left(to: leftAnchor, constant: UserInfoResources.Constraint.imageLeftConstraint)
            .width(constant: UserInfoResources.Constraint.imageWidthConstraint)
            .height(constant: UserInfoResources.Constraint.imageHeightConstraint)
            .activate()
        
        let stack = createStack()
        addSubview(stack)
        stack.anchor()
            .centerYToSuperview()
            .left(to: image.rightAnchor, constant: UserInfoResources.Constraint.stackLeftConstraint)
            .activate()
    }
    
    func createStack() -> UIStackView {
        let stack = VerticalStackView(arrangeSubViews: [
            name,
            date
        ], spacing: UserInfoResources.View.stackSpacing)
        return stack
    }
    
    func configureInit(image: String, name: String, date: Date) {
        self.image.image = UIImage(named: image)
        self.name.text = name
        self.date.text = DateFormatter().convertToMonthAndYears(date)
    }
}
