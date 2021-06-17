//
//  SettingsController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit


private let settingsCellIdentifier = "SettingsCell"

class SettingsController: UITableViewController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: settingsCellIdentifier)
        
        
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource

extension SettingsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Service.shared.settingRows.count // + 1 TODO
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellIdentifier, for: indexPath) as! SettingsCell
        cell.settingsRow = Service.shared.settingRows[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsCell else { return }
        let tableData = Service.shared.getSettingData(fromType: cell.settingsRow!.type)
        
        let controller = SetSettingController(withTableData: tableData, selectedIndex: 0)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}




