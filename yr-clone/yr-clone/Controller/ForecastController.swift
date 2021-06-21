//
//  ForecastController.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit
import CoreLocation

private let cellIdentifier = "ForecastCell"

class ForecastController: UITableViewController {
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    
    private lazy var headerView: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        let button = UIButton(type: .system)
        button.setTitle("Get weather", for: .normal)
        button.addTarget(self, action: #selector(getLocationWeather), for: .touchUpInside)
        button.setDimensions(width: 200, height: 50)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        header.addSubview(button)
        button.centerY(inView: header)
        button.centerX(inView: header)
        return header
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.tableHeaderView = headerView

    }
    
    //MARK: - Actions
    
    @objc func getLocationWeather() {
        print("Get location")
    }
    
    
}
    
extension ForecastController: CLLocationManagerDelegate {
    func getUserLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("DEFAULT location in switch")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        
        locationManager.stopUpdatingLocation()
        weatherManager.fetchWeather(withLatitude: coordinate.latitude, withLongitude: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in locationManager: \(error)")
    }
}
    
    
//MARK: - UITableViewDelegate and UITableViewDataSource
extension ForecastController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header \(section)"
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = ""
        
        return cell
    }
}

extension ForecastController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print("Failed with error: \(error)")
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print("WEATHER: \(weather)")
        DispatchQueue.main.async {
           // self.temperatureLabel.text = weather.temperatureString
            //self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            //self.cityLabel.text = weather.cityName
        }
    }   
    
}
