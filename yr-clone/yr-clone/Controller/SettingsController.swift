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
    
    private var currentTypeSelection: SettingType?
    private var lastSelectedCell: SettingsCell?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: settingsCellIdentifier)
        
        
    }
    
    
    //MARK: - Helpers
    
    func handleNewDataSelection(withIndex index: Int) {
        guard let currentType = currentTypeSelection else { return }
        let newData = Service.shared.getItemFromSettingData(withType: currentType, withIndex: index)
        
        guard let cell = lastSelectedCell else { return }
        
        cell.selectionText.text = newData
        
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
        lastSelectedCell = cell
        
        guard let selectedRowType = cell.settingsRow?.type else { return }
        
        currentTypeSelection = selectedRowType
        let tableData = Service.shared.getSettingData(fromType: selectedRowType)
        
        let controller = SetSettingController(withTableData: tableData, selectedIndex: 0, parentController: self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}




