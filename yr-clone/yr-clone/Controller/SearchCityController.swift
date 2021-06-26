//
//  SearchCityController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-26.
//

import UIKit

class SearchCityController: UITableViewController {
    
    //MARK: - Properties

    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "My locations"
        return label
    }()
    
    private let headerSearchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search city"
        return bar
    }()
    
    private lazy var tableHeader: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))

        let closeButton = UIButton(type: .system)
        let closeIcon = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        closeButton.setImage(closeIcon, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        header.addSubview(closeButton)
        closeButton.anchor(top: header.topAnchor, right: header.rightAnchor, paddingTop: 15, paddingRight: 15)
        
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        header.addSubview(searchBar)
        searchBar.centerY(inView: header, leftAnchor: header.leftAnchor, paddingLeft: 20, constant: 20)
        searchBar.anchor(right: header.rightAnchor, paddingRight: 20)
        
        let icon = UIImageView(image: #imageLiteral(resourceName: "yr-icon").withRenderingMode(.alwaysOriginal))
        icon.setDimensions(width: 40, height: 40)
        header.addSubview(icon)
        icon.centerY(inView: header, constant: -10)
        icon.centerX(inView: searchBar)
        
        return header
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.tableHeaderView = tableHeader
        
    }
    
    
    //MARK: - Actions
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Helpers
    
}




//MARK: - TableViewDelegate and DataSource

extension SearchCityController {
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    
}
