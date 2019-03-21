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
        label.text = "あなたのチームはfarでお間違い無いですか？"
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
        confirmationTeamTitle.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        confirmationTeamTitle.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(confirmationTeamId)
        confirmationTeamId.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        confirmationTeamId.topAnchor.constraint(equalTo: confirmationTeamTitle.bottomAnchor, constant: vc.view.bounds.size.width / 2.5).isActive = true
        vc.view.addSubview(confirmBtn)
        confirmBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        confirmBtn.topAnchor.constraint(equalTo: confirmationTeamId.bottomAnchor, constant: vc.view.bounds.size.width / 3.5).isActive = true
        confirmBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        vc.view.addSubview(cancelBtn)
        cancelBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        cancelBtn.topAnchor.constraint(equalTo: confirmBtn.bottomAnchor, constant: vc.view.bounds.size.width / 9.5).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
    }
}
