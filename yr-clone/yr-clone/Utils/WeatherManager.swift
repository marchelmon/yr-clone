//
//  WeatherManager.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-20.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    
    private let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=0ce0d5426849eda5b4f59f0540eb2789&units=metric"
    private let foreCastUrl = "https://api.openweathermap.org/data/2.5/forecast?appid=0ce0d5426849eda5b4f59f0540eb2789&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(forCity city: String) {
        let urlString = "\(weatherUrl)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(withLatitude lat: CLLocationDegrees, withLongitude lon: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: urlString)
    }
    
    func fetchForecast(forCity city: String) {
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name.components(separatedBy: " ").first ?? "Unknown"
            let wind = decodedData.wind
            let date = decodedData.dt_txt?.components(separatedBy: " ")[0] ?? "00-00-0000"
            let time = decodedData.dt_txt?.components(separatedBy: " ")[1] ?? "00:00"
            var rain = 0.0
            if let rainData = decodedData.rain {
                rain = (rainData.oneHour != nil ? rainData.oneHour : rainData.threeHour) ?? 0.0
            }
            return WeatherModel(conditionId: id, cityName: name, temp: temp, wind: wind, rain: rain, date: date, time: time)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
