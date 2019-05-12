import Foundation
import UIKit

protocol TeamIdWriteUI: UI {
    var noticeTeamTitle: UILabel { get }
    var noticeTeamText: UILabel { get }
    var teamIdField: CustomTextField { get }
    var confirmTeamIdBtn: UIButton { get }
    
    func setup(vc: UIViewController)
}

final class TeamIdWriteUIImpl: TeamIdWriteUI {
    
    weak var viewController: UIViewController?
    
    private(set) var noticeTeamTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_write_team_id()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        return label
    }()
    
    private(set) var noticeTeamText: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_confirm()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.numberOfLines = TeamIdWriteResources.View.titleNumberOfLines
        return label
    }()
    
    private(set) var teamIdField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.team_id()
        return field
    }()
    
    private(set) var confirmTeamIdBtn: UIButton = {
        let button = UIButton()
        button.alpha = 0.2
        button.isUserInteractionEnabled = false
        button.setTitle(R.string.locarizable.confirm(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TeamIdWriteResources.View.confirmBtnCornerRadius
        return button
    }()
}

extension TeamIdWriteUIImpl {
    
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.team_id()
        [noticeTeamTitle, noticeTeamText, teamIdField, confirmTeamIdBtn].forEach { vc.view.addSubview($0) }
        
        noticeTeamTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        noticeTeamText.anchor()
            .centerXToSuperview()
            .top(to: noticeTeamTitle.bottomAnchor, constant: vc.view.bounds.size.width / 4)
            .width(constant: vc.view.bounds.size.width - TeamIdWriteResources.Constraint.noticeTeamTextWidthConstraint)
            .activate()
        
        teamIdField.anchor()
            .centerXToSuperview()
            .top(to: noticeTeamText.bottomAnchor, constant: vc.view.bounds.size.width / 4.5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        confirmTeamIdBtn.anchor()
            .centerXToSuperview()
            .top(to: teamIdField.bottomAnchor, constant: vc.view.bounds.size.width / 3.5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
}
