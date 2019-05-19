import Foundation
import UIKit
import PopupDialog

protocol SettingsUI: UI {
    var settingsTable: UITableView { get }
    
    func setup()
    func createLogoutAlert(vc: UIViewController, completion: @escaping () -> Void)
}

final class SettingsUIImpl: SettingsUI {
    
    var viewController: UIViewController?
    
    var settingsTable: UITableView = {
        let table = UITableView()
        table.separatorColor = AppResources.ColorResources.appCommonClearColor
        table.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return table
    }()
}

extension SettingsUIImpl {
    func setup() {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.view.addSubview(settingsTable)
        settingsTable.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .left(to: vc.view.leftAnchor)
            .right(to: vc.view.rightAnchor)
            .bottom(to: vc.view.bottomAnchor)
            .activate()
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
