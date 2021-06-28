//
//  FavoritesController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit

class FavoritesController: UITableViewController {
    
    //MARK: - Properties
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        navigationItem.title = Service.shared.lastForecast?.city.name ?? "Nomansland"
        
    }
    
    //MARK: - Actions
    @IBAction func pressedStar(_ sender: UIBarButtonItem) {
        
    }
}


m
