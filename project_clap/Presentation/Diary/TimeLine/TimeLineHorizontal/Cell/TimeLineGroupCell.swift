import UIKit

class TimeLineGroupCell: UICollectionViewCell {
    
    var timeLineHorizontalController = TimeLineHorizontalController()
    
    private lazy var submittedTitle: UILabel = {
        let label = UILabel()
        label.text = "12月1日"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(submittedTitle)
        submittedTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2, left: 16, bottom: 2, right: 0))
        addSubview(timeLineHorizontalController.view)
        timeLineHorizontalController.view.anchor(top: submittedTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        timeLineHorizontalController.collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
