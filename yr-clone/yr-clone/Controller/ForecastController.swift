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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

    }
    
    //MARK: - API
    
    func getCurrentWeather(withLocation: CLLocationCoordinate2D) {
        
        
        
    }
    
    
    //MARK: - Actions
    
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
        
//        location.fetchCityAndCountry { (city, country, error) in
//
//            guard let city = city else { return }
//
//            self.locationTapView.viewText.textColor = UIColor(white: 0.1, alpha: 0.9)
//            self.locationTapView.viewText.text = city
//
//        }
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
        print("The weather at my location is: \()")
    }
    
}
