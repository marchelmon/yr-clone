//
//  SearchCityController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-26.
//

import UIKit
import CoreLocation

private let currentLocationCell = "CurrentCell"
private let resultCell = "ResultCell"

class SearchCityController: UITableViewController {
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    var currentLocationWeather: WeatherModel?
    
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
        
        locationManager.delegate = self
        weatherManager.delegate = self
        
        tableView.tableHeaderView = tableHeader
        tableView.separatorStyle = .none
        tableView.register(LocationCell.self, forCellReuseIdentifier: currentLocationCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: resultCell)
        
        guard let currentLocation = Service.shared.currentLocation else { return }
        weatherManager.fetchWeather(withLatitude: currentLocation.latitude, withLongitude: currentLocation.longitude)
        
    }
    
    //MARK: - Actions
    
    
    //MARK: - Helpers
    
}


//MARK: - TableViewDelegate and DataSource

extension SearchCityController {
    override func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return section == 0 ? searchResults.count : 1 }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return section == 1 ? "Current location" : nil }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return indexPath.section == 0 ? 40 : 80 }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(white: 0.1, alpha: 0.8)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: currentLocationCell) as! LocationCell
            cell.weather = currentLocationWeather
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: resultCell, for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            print("Delegate goes back to forecast")
        }
        if indexPath.section == 1 {
            getUserLocation()
        }
    }
    
}

//MARK: - WeatherManagerDelegate
extension SearchCityController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print("Fetch Weather error: \(error.localizedDescription)")
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        currentLocationWeather = weather
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateForecast(_ weatherManager: WeatherManager, forecastData: [WeatherModel]) {
        print("Updated forecst in searchcitycontroller")
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






//MARK: - CLLocationManagerDelegate
extension SearchCityController: CLLocationManagerDelegate {
    func getUserLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied: locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways: locationManager.startUpdatingLocation()
        case .authorizedWhenInUse: locationManager.startUpdatingLocation()
        @unknown default: print("Get location bull") }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        Service.shared.currentLocation = coordinate

        weatherManager.fetchWeather(withLatitude: coordinate.latitude, withLongitude: coordinate.longitude)

        locationManager.stopUpdatingLocation()
    }
}
