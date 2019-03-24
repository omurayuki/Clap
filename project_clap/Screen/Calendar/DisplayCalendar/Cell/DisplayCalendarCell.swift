import UIKit
import JTAppleCalendar

class DisplayCalendarCell: JTAppleCell {
    
    lazy var stateOfDateAtCalendar: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var selectedDateMarker: UIView = {
        let view = UIView()
        view.layer.cornerRadius = DisplayCalendarResources.View.selectedDateMarkerLayerCornerRadius
        view.isHidden = true
        view.backgroundColor = AppResources.ColorResources.shallowBlueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var calendarEventDots: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .gray
        label.layer.cornerRadius = DisplayCalendarResources.View.calendarEventDotsLayerCornerRadius
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DisplayCalendarCell {
    private func setupUI() {
        contentView.addSubview(selectedDateMarker)
        contentView.addSubview(stateOfDateAtCalendar)
        contentView.addSubview(calendarEventDots)
        
        selectedDateMarker.anchor()
            .centerToSuperview()
            .width(constant: DisplayCalendarResources.Constraint.selectedDateMarkerWidthConstraint)
            .height(constant: DisplayCalendarResources.Constraint.selectedDateMarkerHeightConstraint)
            .activate()
        
        stateOfDateAtCalendar.anchor()
            .centerX(to: selectedDateMarker.centerXAnchor)
            .centerY(to: contentView.centerYAnchor)
            .activate()
        
        calendarEventDots.anchor()
            .centerXToSuperview()
            .top(to: stateOfDateAtCalendar.bottomAnchor, constant: DisplayCalendarResources.Constraint.calendarEventDotsTopConstraint)
            .width(constant: DisplayCalendarResources.Constraint.calendarEventDotsWidthConstraint)
            .height(constant: DisplayCalendarResources.Constraint.calendarEventDotsHeightConstraint)
            .activate()
    }
    
    func configureInit(stateOfDateAtCalendar: String) {
        self.stateOfDateAtCalendar.text = stateOfDateAtCalendar
    }
}
