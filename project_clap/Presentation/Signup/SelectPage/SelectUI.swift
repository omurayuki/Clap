import Foundation
import UIKit

protocol SelectUI: UI {
    var selectionTeamOrMemberTitle: UILabel { get }
    var teamRegistBtn: UIButton { get }
    var memberRegistBtn: UIButton { get }
    var btnStack: UIStackView { get }
    
    func setup(storeName: String)
}

final class SelectUIImpl: SelectUI {
    
    weak var viewController: UIViewController?
    
    private(set) var selectionTeamOrMemberTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.select_usage_type()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        return label
    }()
    
    private(set) var teamRegistBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = SelectResources.View.btnCornerRadius
        button.backgroundColor = AppResources.ColorResources.shallowBlueColor
        button.setImage(R.image.regist_team(), for: .normal)
        return button
    }()
    
    private(set) var memberRegistBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = SelectResources.View.btnCornerRadius
        button.backgroundColor = AppResources.ColorResources.shallowBlueColor
        button.setImage(R.image.join_to_team(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var btnStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
}

extension SelectUIImpl {
    func setup(storeName: String) {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.navigationItem.title = storeName
        [teamRegistBtn, memberRegistBtn].forEach { btnStack.addArrangedSubview($0) }
        [selectionTeamOrMemberTitle, btnStack].forEach {vc.view.addSubview($0) }
        selectionTeamOrMemberTitle.anchor()
            .centerXToSuperview()
            .top(to: vc.view.topAnchor, constant: vc.view.bounds.size.width / 2.5)
            .activate()
        
        btnStack.anchor()
            .centerXToSuperview()
            .centerYToSuperview()
            .activate()
        
        teamRegistBtn.anchor()
            .width(constant: vc.view.bounds.size.width / 3.5)
            .height(constant: vc.view.bounds.size.width / 3.5)
            .activate()
        
        memberRegistBtn.anchor()
            .width(constant: vc.view.bounds.size.width / 3.5)
            .height(constant: vc.view.bounds.size.width / 3.5)
            .activate()
        
        memberRegistBtn.leftAnchor.constraint(equalTo: teamRegistBtn.rightAnchor, constant: vc.view.bounds.size.width / 5.5).isActive = true
    }
}
