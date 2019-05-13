import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var ui: SettingsUI = {
        let ui = SettingsUIImpl()
        ui.settingsTable.dataSource = self
        ui.settingsTable.delegate = self
        ui.viewController = self
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setup()
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSection(rawValue: section) else { return nil }
        switch section {
        case .account: return section.title
        case .general: return section.title
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .account: return AccountItem.sharedItems.count
        case .general: return GeneralItem.sharedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .account:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.textLabel?.text = AccountItem.sharedItems[indexPath.row].title
            cell.textLabel?.font = AppResources.FontResources.defaultCellFont
            cell.accessoryType = .disclosureIndicator
            return cell
        case .general:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.textLabel?.text = GeneralItem.sharedItems[indexPath.row].title
            cell.textLabel?.font = AppResources.FontResources.defaultCellFont
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        #warning("各画面遷移")
    }
}
