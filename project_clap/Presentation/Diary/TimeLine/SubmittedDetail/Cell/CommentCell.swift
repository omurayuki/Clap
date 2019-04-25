import Foundation
import UIKit

class commentCell: UITableViewCell {
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var comment: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var replyCountBtn: UIButton = {
        let button = UIButton()
        button.setTitle("返信を表示する", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
