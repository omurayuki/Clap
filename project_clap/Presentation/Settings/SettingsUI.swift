import Foundation
import UIKit

protocol SettingsUI: UI {
    var settingsTable: UITableView { get }
    
    func setup()
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
}
