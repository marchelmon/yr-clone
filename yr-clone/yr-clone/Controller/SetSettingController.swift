//
//  SetSettingController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-17.
//

import UIKit

private let reuseIdentifier = "SetSettingCell"

class SetSettingController: UITableViewController {
    
    
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource

extension SetSettingController {
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
        
        
        
    }
    
    
}
