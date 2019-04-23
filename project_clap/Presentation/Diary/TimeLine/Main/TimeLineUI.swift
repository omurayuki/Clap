import UIKit

protocol TimeLineUI: UI {
    var timelineTableView: UITableView { get }
    var menuBtn: UIButton { get }
    var memberBtn: UIButton { get }
    var diaryBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func hiddenBtnPosition(vc: UIViewController)
    func showBtnPosition(vc: UIViewController)
}

class TimeLineUIImpl: TimeLineUI {
    
    weak var viewController: UIViewController?
    
    private(set) var timelineTableView: UITableView = {
        let table = UITableView()
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
    
    private(set) var memberBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle("＊", for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        return button
    }()
    
    private(set) var diaryBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle("＠", for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        return button
    }()
}

extension TimeLineUIImpl {
    func setup(vc: UIViewController) {
        vc.navigationItem.title = R.string.locarizable.time_line()
        
        vc.view.addSubview(timelineTableView)
        timelineTableView.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .width(to: vc.view.widthAnchor)
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .bottom(to: vc.view.safeAreaLayoutGuide.bottomAnchor)
            .activate()
        
        vc.view.addSubview(menuBtn)
        menuBtn.anchor(top: nil,
                       leading: nil,
                       bottom: vc.view.safeAreaLayoutGuide.bottomAnchor,
                       trailing: vc.view.trailingAnchor,
                       padding: .init(top: 0, left: 0, bottom: 10, right: 10))
        menuBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        menuBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
        
        vc.view.addSubview(memberBtn)
        memberBtn.anchor(top: nil,
                         leading: nil,
                         bottom: vc.view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: menuBtn.leadingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 10, right: 50))
        memberBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        memberBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
        
        vc.view.addSubview(diaryBtn)
        diaryBtn.anchor(top: nil,
                        leading: nil,
                        bottom: menuBtn.topAnchor,
                        trailing: vc.view.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 50, right: 10))
        diaryBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        diaryBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
    }
    
    func hiddenBtnPosition(vc: UIViewController) {
        memberBtn.anchor(top: nil,
                         leading: nil,
                         bottom: vc.view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: menuBtn.leadingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 10, right: 50))
        memberBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        memberBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
        
        diaryBtn.anchor(top: nil,
                        leading: nil,
                        bottom: menuBtn.topAnchor,
                        trailing: vc.view.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 50, right: 10))
        diaryBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        diaryBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
    }
    
    func showBtnPosition(vc: UIViewController) {
        memberBtn.anchor(top: nil,
                         leading: nil,
                         bottom: vc.view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: menuBtn.leadingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        memberBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        memberBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
        
        diaryBtn.anchor(top: nil,
                        leading: nil,
                        bottom: menuBtn.topAnchor,
                        trailing: vc.view.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        diaryBtn.constrainWidth(constant: TimeLineResources.Constraint.BtnWidthConstraint)
        diaryBtn.constrainHeight(constant: TimeLineResources.Constraint.BtnHeightConstraint)
    }
}
