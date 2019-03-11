import Foundation
import UIKit

class DisplayEventCell: UITableViewCell {
    
    private lazy var startTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var endTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var displayEvent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DisplayEventCell {
    private func setupUI() {
        contentView.addSubview(startTime)
        startTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        startTime.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        contentView.addSubview(endTime)
        endTime.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        endTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        contentView.addSubview(displayEvent)
        displayEvent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        displayEvent.leftAnchor.constraint(equalTo: startTime.rightAnchor, constant: 20).isActive = true
    }
    
    func configureInit(start: String, end: String, event: String) {
        startTime.text = "開始 \(start)"
        endTime.text = "終了 \(end)"
        displayEvent.text = event
    }
}
