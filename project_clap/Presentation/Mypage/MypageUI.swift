import Foundation
import UIKit
import PopupDialog

protocol MypageUI: UI {
    var editBtn: UIBarButtonItem { get }
    var logoutBtn: UIBarButtonItem { get }
    var userPhoto: UIImageView { get }
    var userPhotoWrapView: CustomView { get }
    var belongTitle: UILabel { get }
    var belongTeam: UILabel { get }
    var belongStack: CustomStackView { get }
    var positionTitle: UILabel { get }
    var position: UILabel { get }
    var positionStack: CustomStackView { get }
    var teamIdTitle: UILabel { get }
    var teamId: UILabel { get }
    var teamIdStack: CustomStackView { get }
    var mailTitle: UILabel { get }
    var mail: UILabel { get }
    var mailStack: CustomStackView { get }
    
    func setup(vc: UIViewController)
    func setupInsideStack(vc: UIViewController)
    func createLogoutAlert(vc: UIViewController, completion: @escaping () -> Void)
}

final class MypageUIImpl: MypageUI {
    
    weak var viewController: UIViewController?
    
    private(set) var editBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.edit(), style: .plain, target: nil, action: nil)
        return button
    }()
    
    private(set) var logoutBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.logout(), style: .plain, target: nil, action: nil)
        return button
    }()
    
    private(set) var userPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = MypageResources.View.userPhotoLayerCornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private(set) var userPhotoWrapView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var belongTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.belong()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var belongTeam: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Loading.."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var belongStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var positionTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.position()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var position: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Loading.."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var positionStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var teamIdTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.teamId()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var teamId: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Loading.."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var teamIdStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var mailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.mail()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var mail: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Loading.."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var mailStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
}

extension MypageUIImpl {
    func setup(vc: UIViewController) {
        vc.view.backgroundColor = .white
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        vc.navigationController?.navigationBar.barTintColor = .white
        vc.navigationItem.title = R.string.locarizable.mypage_title()
        vc.navigationItem.leftBarButtonItem = logoutBtn
        vc.navigationItem.rightBarButtonItem = editBtn
        vc.view.addSubview(userPhotoWrapView)
        [belongTitle, belongTeam].forEach { belongStack.addArrangedSubview($0) }
        [positionTitle, position].forEach { positionStack.addArrangedSubview($0) }
        [teamIdTitle, teamId].forEach { teamIdStack.addArrangedSubview($0) }
        [mailTitle, mail].forEach { mailStack.addArrangedSubview($0) }
        userPhotoWrapView.addSubview(userPhoto)
        [belongStack, positionStack, teamIdStack, mailStack].forEach { vc.view.addSubview($0) }
        
        userPhotoWrapView.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .width(constant: vc.view.bounds.size.width)
            .activate()
        
        userPhoto.anchor()
            .centerXToSuperview()
            .top(to: userPhotoWrapView.topAnchor, constant: MypageResources.Constraint.userPhotoTopConstraint)
            .bottom(to: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.userPhotoBottomConstraint)
            .width(constant: MypageResources.Constraint.userPhotoWidthConstraint)
            .height(constant: MypageResources.Constraint.userPhotoHeightConstraint)
            .activate()
        
        belongStack.anchor()
            .top(to: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.belongStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
        
        positionStack.anchor()
            .top(to: belongStack.bottomAnchor, constant: MypageResources.Constraint.positionStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
        
        teamIdStack.anchor()
            .top(to: positionStack.bottomAnchor, constant: MypageResources.Constraint.teamIdStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
        
        mailStack.anchor()
            .top(to: teamIdStack.bottomAnchor, constant: MypageResources.Constraint.mailStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
    }
    
    func setupInsideStack(vc: UIViewController) {
        belongTitle.leftAnchor.constraint(equalTo: belongStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        positionTitle.leftAnchor.constraint(equalTo: positionStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        teamIdTitle.leftAnchor.constraint(equalTo: teamIdStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        mailTitle.leftAnchor.constraint(equalTo: mailStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        belongTeam.leftAnchor.constraint(equalTo: belongTitle.rightAnchor, constant: MypageResources.Constraint.belongTeamLeftConstraint).isActive = true
        position.leftAnchor.constraint(equalTo: positionTitle.rightAnchor, constant: MypageResources.Constraint.positionLeftConstraint).isActive = true
        teamId.leftAnchor.constraint(equalTo: teamIdTitle.rightAnchor, constant: MypageResources.Constraint.teamIdLeftConstraint).isActive = true
        mail.leftAnchor.constraint(equalTo: mailTitle.rightAnchor, constant: MypageResources.Constraint.mailLeftConstraint).isActive = true
    }
    
    func createLogoutAlert(vc: UIViewController, completion: @escaping () -> Void) {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.do_you_wanto_logout())
        let logout = DefaultButton(title: R.string.locarizable.yes()) {
            vc.present(UINavigationController(rootViewController: TopViewController()), animated: true, completion: {
                completion()
            })
        }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) {}
        alert.addButtons([logout, cancel])
        vc.present(alert, animated: true)
    }
}
