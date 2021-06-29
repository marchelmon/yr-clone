//
//  FavoritesController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit

private let favoriteCell = "FavoriteCell"

class FavoritesController: UITableViewController {
    
    //MARK: - Properties
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = Service.shared.lastForecast?.city.name ?? "Nomansland"
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: favoriteCell)
        
    }
    
    //MARK: - Actions
    @IBAction func pressedStar(_ sender: UIBarButtonItem) {
        
    }
}


//MARK: - UITableViewDelegate / UITableViewDataSource
extension FavoritesController {
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    //override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return "" }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return Service.shared.favoriteLocations.count }
}
