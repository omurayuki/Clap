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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var noticeTeamText: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_confirm()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.numberOfLines = TeamIdWriteResources.View.titleNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var teamIdField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = R.string.locarizable.team_id()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var confirmTeamIdBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        vc.view.addSubview(noticeTeamTitle)
        noticeTeamTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        noticeTeamTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(noticeTeamText)
        noticeTeamText.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        noticeTeamText.topAnchor.constraint(equalTo: noticeTeamTitle.bottomAnchor, constant: vc.view.bounds.size.width / 4).isActive = true
        noticeTeamText.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width - TeamIdWriteResources.Constraint.noticeTeamTextWidthConstraint).isActive = true
        vc.view.addSubview(teamIdField)
        teamIdField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        teamIdField.topAnchor.constraint(equalTo: noticeTeamText.bottomAnchor, constant: vc.view.bounds.size.width / 4.5).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(confirmTeamIdBtn)
        confirmTeamIdBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        confirmTeamIdBtn.topAnchor.constraint(equalTo: teamIdField.bottomAnchor, constant: vc.view.bounds.size.width / 3.5).isActive = true
        confirmTeamIdBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
    }
}
