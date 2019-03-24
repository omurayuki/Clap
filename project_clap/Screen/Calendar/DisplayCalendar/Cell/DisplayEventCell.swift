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
        wrapView.anchor()
            .top(to: contentView.topAnchor, constant: DisplayCalendarResources.Constraint.wrapViewTopConstraint)
            .left(to: contentView.leftAnchor, constant: DisplayCalendarResources.Constraint.wrapViewLeftConstraint)
            .bottom(to: contentView.bottomAnchor, constant: DisplayCalendarResources.Constraint.wrapViewBottomConstraint)
            .right(to: contentView.rightAnchor, constant: DisplayCalendarResources.Constraint.wrapViewRightConstraint)
            .activate()
        
        setupInsideWrapView()
    }
    
    private func setupInsideWrapView() {
        wrapView.addSubview(startTime)
        wrapView.addSubview(endTime)
        wrapView.addSubview(displayEvent)
        
        startTime.anchor()
            .top(to: wrapView.topAnchor, constant: DisplayCalendarResources.Constraint.startTimeTopConstraint)
            .left(to: wrapView.leftAnchor, constant: DisplayCalendarResources.Constraint.startTimeLeftConstraint)
            .activate()
        
        endTime.anchor()
            .left(to: wrapView.leftAnchor, constant: DisplayCalendarResources.Constraint.endTimeLeftConstraint)
            .bottom(to: wrapView.bottomAnchor, constant: DisplayCalendarResources.Constraint.endTimeBottomConstraint)
            .activate()
        
        displayEvent.anchor()
            .centerY(to: wrapView.centerYAnchor)
            .left(to: startTime.rightAnchor, constant: DisplayCalendarResources.Constraint.displayEventLeftConstraint)
            .activate()
    }
    
    func configureInit(start: String, end: String, event: String) {
        startTime.text = "開始 \(start)"
        endTime.text = "終了 \(end)"
        displayEvent.text = event
    }
}
