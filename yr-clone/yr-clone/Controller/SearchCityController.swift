//
//  SearchCityController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-26.
//

import UIKit

class SearchCityController: UITableViewController {
    
    //MARK: - Properties
    
    var searchResults = [String]()
    var isEditingSearch = false

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
        searchBar.delegate = self
        
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if isEditingSearch {
            row = searchResults.count > 0 ? searchResults.count : 1
        } else {
            //row = antal tillagda favorites
        }
        return row
    }
    
    
    
    
}


//MARK: - UISearchBarDelegate

extension SearchCityController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isEditingSearch = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isEditingSearch = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text did change: \(searchText)")
    }
    
}
