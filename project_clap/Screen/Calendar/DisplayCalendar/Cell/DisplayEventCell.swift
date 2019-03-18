import Foundation
import UIKit

class DisplayEventCell: UITableViewCell {
    
    private lazy var startTime: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.startTimeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var endTime: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.endTimeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var displayEvent: UILabel = {
        let label = UILabel()
        label.font = DisplayCalendarResources.Font.displayEventFont
        label.translatesAutoresizingMaskIntoConstraints = false
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

extension DisplayEventCell {
    private func setupUI() {
        contentView.backgroundColor = AppResources.ColorResources.appCommonClearColor
        contentView.addSubview(wrapView)
        wrapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DisplayCalendarResources.Constraint.wrapViewTopConstraint).isActive = true
        wrapView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: DisplayCalendarResources.Constraint.wrapViewLeftConstraint).isActive = true
        wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: DisplayCalendarResources.Constraint.wrapViewBottomConstraint).isActive = true
        wrapView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: DisplayCalendarResources.Constraint.wrapViewRightConstraint).isActive = true
        setupInsideWrapView()
    }
    
    private func setupInsideWrapView() {
        wrapView.addSubview(startTime)
        startTime.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: DisplayCalendarResources.Constraint.startTimeTopConstraint).isActive = true
        startTime.leftAnchor.constraint(equalTo: wrapView.leftAnchor, constant: DisplayCalendarResources.Constraint.startTimeLeftConstraint).isActive = true
        wrapView.addSubview(endTime)
        endTime.leftAnchor.constraint(equalTo: wrapView.leftAnchor, constant: DisplayCalendarResources.Constraint.endTimeLeftConstraint).isActive = true
        endTime.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: DisplayCalendarResources.Constraint.endTimeLeftConstraint).isActive = true
        wrapView.addSubview(displayEvent)
        displayEvent.centerYAnchor.constraint(equalTo: wrapView.centerYAnchor).isActive = true
        displayEvent.leftAnchor.constraint(equalTo: startTime.rightAnchor, constant: DisplayCalendarResources.Constraint.displayEventLeftConstraint).isActive = true
    }
    
    func configureInit(start: String, end: String, event: String) {
        startTime.text = "開始 \(start)"
        endTime.text = "終了 \(end)"
        displayEvent.text = event
    }
}
