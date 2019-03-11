import Foundation
import UIKit
import RxSwift
import RxCocoa
import PopupDialog

class MypageViewController: UIViewController {
    
    private lazy var editBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.edit(), style: .plain, target: self, action: #selector(showEditPage))
        return button
    }()
    
    private lazy var logoutBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: R.string.locarizable.logout(), style: .plain, target: self, action: #selector(showLogoutDiaplog))
        return button
    }()
    
    private lazy var userPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = MypageResources.View.userPhotoLayerCornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userPhotoWrapView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var belongTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.belong()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var belongTeam: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "京都産業大学ラグビー部"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var belongStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(belongTitle)
        stack.addArrangedSubview(belongTeam)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var positionTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.position()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var position: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "プロップ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var positionStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(positionTitle)
        stack.addArrangedSubview(position)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var teamIdTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.teamId()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamId: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "fkerjf0fdiosfjw@10"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamIdStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(teamIdTitle)
        stack.addArrangedSubview(teamId)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.mail()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mail: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "2@2.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mailStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(mailTitle)
        stack.addArrangedSubview(mail)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInsideStack()
    }
}

extension MypageViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.mypage_title()
        navigationItem.leftBarButtonItem = logoutBtn
        navigationItem.rightBarButtonItem = editBtn
        view.addSubview(userPhotoWrapView)
        userPhotoWrapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userPhotoWrapView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        userPhotoWrapView.addSubview(userPhoto)
        userPhoto.centerXAnchor.constraint(equalTo: userPhotoWrapView.centerXAnchor).isActive = true
        userPhoto.topAnchor.constraint(equalTo: userPhotoWrapView.topAnchor, constant: MypageResources.Constraint.userPhotoTopConstraint).isActive = true
        userPhoto.bottomAnchor.constraint(equalTo: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.userPhotoBottomConstraint).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: MypageResources.Constraint.userPhotoWidthConstraint).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: MypageResources.Constraint.userPhotoHeightConstraint).isActive = true
        view.addSubview(belongStack)
        belongStack.topAnchor.constraint(equalTo: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.belongStackTopConstraint).isActive = true
        belongStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        belongStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
        view.addSubview(positionStack)
        positionStack.topAnchor.constraint(equalTo: belongStack.bottomAnchor, constant: MypageResources.Constraint.positionStackTopConstraint).isActive = true
        positionStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        positionStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
        view.addSubview(teamIdStack)
        teamIdStack.topAnchor.constraint(equalTo: positionStack.bottomAnchor, constant: MypageResources.Constraint.teamIdStackTopConstraint).isActive = true
        teamIdStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        teamIdStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
        view.addSubview(mailStack)
        mailStack.topAnchor.constraint(equalTo: teamIdStack.bottomAnchor, constant: MypageResources.Constraint.mailStackTopConstraint).isActive = true
        mailStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        mailStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
    }
    
    private func setupInsideStack() {
        belongTitle.leftAnchor.constraint(equalTo: belongStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        positionTitle.leftAnchor.constraint(equalTo: positionStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        teamIdTitle.leftAnchor.constraint(equalTo: teamIdStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        mailTitle.leftAnchor.constraint(equalTo: mailStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        belongTeam.leftAnchor.constraint(equalTo: belongTitle.rightAnchor, constant: MypageResources.Constraint.belongTeamLeftConstraint).isActive = true
        position.leftAnchor.constraint(equalTo: positionTitle.rightAnchor, constant: MypageResources.Constraint.positionLeftConstraint).isActive = true
        teamId.leftAnchor.constraint(equalTo: teamIdTitle.rightAnchor, constant: MypageResources.Constraint.teamIdLeftConstraint).isActive = true
        mail.leftAnchor.constraint(equalTo: mailTitle.rightAnchor, constant: MypageResources.Constraint.mailLeftConstraint).isActive = true
    }
    
    private func createLogoutAlert() {
        let alert = PopupDialog(title: R.string.locarizable.message(), message: R.string.locarizable.do_you_wanto_logout())
        let logout = DefaultButton(title: R.string.locarizable.yes()) { self.present(UINavigationController(rootViewController: TopViewController()), animated: true) }
        let cancel = CancelButton(title: R.string.locarizable.cancel()) { self.dismiss(animated: true) }
        alert.addButtons([logout, cancel])
        self.present(alert, animated: true)
    }
    
    @objc
    private func showEditPage() {
        navigationController?.pushViewController(MypageEditViewController(), animated: true)
    }
    
    @objc
    private func showLogoutDiaplog() {
        createLogoutAlert()
    }
}
