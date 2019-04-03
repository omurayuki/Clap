import Foundation
import UIKit

protocol ConfirmationTeamIdUI: UI {
    var confirmationTeamTitle: UILabel { get }
    var confirmationTeamId: UILabel { get }
    var confirmBtn: UIButton { get }
    var cancelBtn: UIButton { get }
    
    func setup(storeName: String, vc: UIViewController)
}

final class ConfirmationTeamIdUIImpl: ConfirmationTeamIdUI {
    
    weak var viewController: UIViewController?
    
    private(set) var confirmationTeamTitle: UILabel = {
        let label = UILabel()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.numberOfLines = ConfirmationTeamIdResources.View.titleNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var confirmationTeamId: UILabel = {
        let label = UILabel()
        label.font = AppResources.FontResources.confirmationTeamIdFont
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.addUnderLine(text: label.text)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var confirmBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.yes(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = ConfirmationTeamIdResources.View.confirmBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.cancel(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = ConfirmationTeamIdResources.View.confirmBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension ConfirmationTeamIdUIImpl {
    
    func setup(storeName: String, vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationItem.title = storeName
        vc.view.addSubview(confirmationTeamTitle)
        vc.view.addSubview(confirmationTeamId)
        vc.view.addSubview(confirmBtn)
        vc.view.addSubview(cancelBtn)
        
        confirmationTeamTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        confirmationTeamId.anchor()
            .centerXToSuperview()
            .top(to: confirmationTeamTitle.bottomAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        confirmBtn.anchor()
            .centerXToSuperview()
            .top(to: confirmationTeamId.bottomAnchor, constant: vc.view.bounds.size.width / 3.5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
        
        cancelBtn.anchor()
            .centerXToSuperview()
            .top(to: confirmBtn.bottomAnchor, constant: vc.view.bounds.size.width / 9.5)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
}
