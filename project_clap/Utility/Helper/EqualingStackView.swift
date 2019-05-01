import UIKit

class EqualingStackView: UIStackView {
    init(arrangeSubViews: [UIView]) {
        super.init(frame: .zero)
        arrangeSubViews.forEach { addArrangedSubview($0) }
        self.distribution = .fillEqually
        self.axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
