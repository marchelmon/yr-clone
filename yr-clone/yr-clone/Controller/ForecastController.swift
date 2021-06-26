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
    let forecastData = [WeatherModel]()
    lazy var forecastDictionary: [Int: [WeatherModel]] = [:]

        
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        tableView.register(ForecastCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)

    }
    
    //MARK: - Actions
    
    @objc func getLocationWeather() {
        locationManager.requestLocation()
    }
    
    
    //MARK: - Helpers
    
    func updateForecastDictionary(forecastData: [WeatherModel]) {
        DispatchQueue.main.async {
            var currentSection = 0
            self.forecastDictionary[currentSection] = [WeatherModel]()
            forecastData.forEach { forecast in
                let hour = forecast.date.getHour()
                if (hour == 0 || hour == 1 || hour == 2) && self.forecastDictionary[0]?.count != 0 {
                    if self.forecastDictionary[currentSection] != nil {
                        currentSection += 1
                    }
                    self.forecastDictionary[currentSection] = [WeatherModel]()
                }
                self.forecastDictionary[currentSection]?.append(forecast)
            }
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func searchePressed(_ sender: UIBarButtonItem) {
        let controller = SearchCityController()
        present(controller, animated: true, completion: nil)
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
        //weatherManager.fetchWeather(withLatitude: coordinate.latitude, withLongitude: coordinate.longitude)
        weatherManager.fetchForecast(withLatitude: coordinate.latitude, withLongitude: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in locationManager: \(error)")
    }
}
    
    
//MARK: - UITableViewDelegate and UITableViewDataSource
extension ForecastController {
    override func numberOfSections(in tableView: UITableView) -> Int { return forecastDictionary.count }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 30 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 30 : 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = forecastDictionary[section]?.count else { return 0 }
        return rows + 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forecastDictionary[section]?.first?.dateHeader ?? "No header found"
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(white: 0.1, alpha: 0.9)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        footer.backgroundColor = .white
        let bottomLine = UIView()
        bottomLine.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        footer.addSubview(bottomLine)
        bottomLine.anchor(left: footer.leftAnchor, bottom: footer.bottomAnchor, right: footer.rightAnchor, height: 4)
        let sunLabel = UILabel()
        sunLabel.text = forecastDictionary[section]?.first?.sunsetString
        sunLabel.font = UIFont.systemFont(ofSize: 12)
        sunLabel.textColor = .lightGray
        footer.addSubview(sunLabel)
        sunLabel.centerY(inView: footer)
        sunLabel.centerX(inView: footer)
        return footer
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ForecastCell
        if indexPath.row == 0 {
            cell.configureFirstRowCell()
            return cell
        }
        guard let forecast = forecastDictionary[indexPath.section]?[indexPath.row - 1] else { return cell }
        cell.weather = forecast
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
    func didUpdateForecast(_ weatherManager: WeatherManager, forecastData: [WeatherModel]) {
        updateForecastDictionary(forecastData: forecastData)
        DispatchQueue.main.async {
            self.navigationItem.title = forecastData[0].city.name
        }
    }
    
}
