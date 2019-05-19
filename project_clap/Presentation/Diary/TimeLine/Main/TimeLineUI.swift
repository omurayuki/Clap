import UIKit

protocol TimeLineUI: UI {
    var timelineHeaderView: TimeLineHeader { get }
    var timelineTableView: UITableView { get }
    var menuBtn: UIButton { get }
    var isSelected: Bool { get set }
    
    func setup(vc: UIViewController)
}

class TimeLineUIImpl: TimeLineUI {
    
    weak var viewController: UIViewController?
    var isSelected = false
    
    private(set) var timelineHeaderView: TimeLineHeader = {
        let view = TimeLineHeader()
        return view
    }()
    
    private(set) var timelineTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .singleLine
        table.backgroundColor = AppResources.ColorResources.appCommonClearColor
        table.rowHeight = TimeLineResources.View.tableRowHeight
        table.register(TimelineCell.self, forCellReuseIdentifier: String(describing: TimelineCell.self))
        return table
    }()
    
    private(set) var menuBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        return button
    }()
}

extension TimeLineUIImpl {
    func setup(vc: UIViewController) {
        vc.navigationItem.title = R.string.locarizable.time_line()
        vc.view.backgroundColor = .white
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        vc.navigationController?.navigationBar.barTintColor = AppResources.ColorResources.appCommonClearColor
        [timelineHeaderView, timelineTableView, menuBtn].forEach { vc.view.addSubview($0) }
        
        timelineHeaderView.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .width(constant: vc.view.frame.width)
            .height(constant: vc.view.frame.width / 5)
            .activate()
        
        timelineTableView.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(to: vc.view.widthAnchor)
            .top(to: timelineHeaderView.bottomAnchor)
            .bottom(to: vc.view.safeAreaLayoutGuide.bottomAnchor)
            .activate()
        
        menuBtn.anchor(top: nil,
                       leading: nil,
                       bottom: vc.view.safeAreaLayoutGuide.bottomAnchor,
                       trailing: vc.view.trailingAnchor,
                       padding: .init(top: 0, left: 0, bottom: 10, right: 10))
        menuBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        menuBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
    }
}
