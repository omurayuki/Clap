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
        selectedDateMarker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        selectedDateMarker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectedDateMarker.widthAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.selectedDateMarkerWidthConstraint).isActive = true
        selectedDateMarker.heightAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.selectedDateMarkerHeightConstraint).isActive = true
        contentView.addSubview(stateOfDateAtCalendar)
        stateOfDateAtCalendar.centerXAnchor.constraint(equalTo: selectedDateMarker.centerXAnchor).isActive = true
        stateOfDateAtCalendar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(calendarEventDots)
        calendarEventDots.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        calendarEventDots.topAnchor.constraint(equalTo: stateOfDateAtCalendar.bottomAnchor, constant: DisplayCalendarResources.Constraint.calendarEventDotsTopConstraint).isActive = true
        calendarEventDots.widthAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.calendarEventDotsWidthConstraint).isActive = true
        calendarEventDots.heightAnchor.constraint(equalToConstant: DisplayCalendarResources.Constraint.calendarEventDotsHeightConstraint).isActive = true
    }
    
    func configureInit(stateOfDateAtCalendar: String) {
        self.stateOfDateAtCalendar.text = stateOfDateAtCalendar
    }
}
