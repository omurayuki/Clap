import Foundation
import UIKit
import PopupDialog

//設定でログアウト、チームID確認、メールアドレス確認、
#warning("ハードコード")
protocol MypageUI: UI {
    var settingBtn: UIBarButtonItem { get }
    var wrapView: UIView { get }
    var userPhoto: UIImageView { get }
    var belongTeam: UILabel { get }
    var username: UILabel { get }
    var positionTitle: UILabel { get }
    var position: UILabel { get }
    var teamIdTitle: UILabel { get }
    var teamId: UILabel { get }
    var editBtn: UIButton { get }
    var mypageHeaderView: MypageHeader { get }
    var mypageTable: UITableView { get }
    
    func setup()
    func createLogoutAlert(vc: UIViewController, completion: @escaping () -> Void)
}

final class MypageUIImpl: MypageUI {
    
    weak var viewController: UIViewController?
    
    private(set) var wrapView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) var settingBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "🃖", style: .plain, target: nil, action: nil)
        return button
    }()
    
    private(set) var userPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = MypageResources.View.userPhotoLayerCornerRadius
        return image
    }()
    
    private(set) var belongTeam: UILabel = {
        let label = UILabel()
        label.text = "unKnown.."
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private(set) var username: UILabel = {
        let label = UILabel()
        label.text = "unKnown"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private(set) var positionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = R.string.locarizable.position()
        return label
    }()
    
    private(set) var position: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "unKnown"
        return label
    }()
    
    private(set) var teamIdTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = R.string.locarizable.teamId()
        return label
    }()
    
    private(set) var teamId: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "unKnown"
        return label
    }()
    
    private(set) var editBtn: UIButton = {
        let button = UIButton()
        button.setTitle("プロフィール編集", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private(set) var mypageHeaderView: MypageHeader = {
        let view = MypageHeader()
        return view
    }()
    
    private(set) var mypageTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .singleLine
        table.backgroundColor = AppResources.ColorResources.appCommonClearColor
        table.rowHeight = 70
        table.register(TimelineCell.self, forCellReuseIdentifier: String(describing: TimelineCell.self))
        return table
    }()
}

extension MypageUIImpl {
    
    func setup() {
        guard let vc = viewController else { return }
        vc.navigationItem.title = R.string.locarizable.mypage_title()
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        vc.navigationController?.navigationBar.barTintColor = AppResources.ColorResources.appCommonClearColor
        vc.view.backgroundColor = .white
        vc.navigationItem.rightBarButtonItem = settingBtn
        let userStack = setupUserInfoStack()
        let positionAndStackStack = setupPositionAndTeamIdStack()
        
        [userPhoto, userStack, editBtn, positionAndStackStack, mypageHeaderView, mypageTable].forEach { vc.view.addSubview($0) }
        
        userPhoto.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor, constant: 15)
            .left(to: vc.view.leftAnchor, constant: 15)
            .width(constant: 65)
            .height(constant: 65)
            .activate()
        
        userStack.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor, constant: 15)
            .left(to: userPhoto.rightAnchor, constant: 15)
            .right(to: vc.view.rightAnchor, constant: -15)
            .activate()
        
        editBtn.anchor()
            .top(to: userStack.bottomAnchor, constant: 10)
            .right(to: vc.view.rightAnchor, constant: -15)
            .activate()
        
        positionAndStackStack.anchor()
            .top(to: editBtn.bottomAnchor, constant: 15)
            .left(to: vc.view.leftAnchor, constant: 15)
            .right(to: vc.view.rightAnchor, constant: -15)
            .activate()
        
        mypageHeaderView.anchor()
            .top(to: positionAndStackStack.bottomAnchor, constant: 10)
            .width(constant: vc.view.frame.width)
            .height(constant: vc.view.frame.width / 5)
            .activate()
        
        mypageTable.anchor()
            .top(to: mypageHeaderView.bottomAnchor)
            .left(to: vc.view.leftAnchor)
            .right(to: vc.view.rightAnchor)
            .bottom(to: vc.view.bottomAnchor)
            .activate()
    }
    
    func setupUserInfoStack() -> UIStackView {
        return VerticalStackView(arrangeSubViews: [
            belongTeam,
            username
        ], spacing: 15)
    }
    
    func setupPositionAndTeamIdStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangeSubViews: [
                positionTitle,
                position
            ], spacing: 5),
            VerticalStackView(arrangeSubViews: [
                teamIdTitle,
                teamId
            ], spacing: 5),
            UIStackView()
        ])
        stack.spacing = 50
        return stack
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
