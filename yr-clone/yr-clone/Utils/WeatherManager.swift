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
        let urlString = "\(foreCastUrl)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func fetchForecast(withLatitude lat: CLLocationDegrees, withLongitude lon: CLLocationDegrees) {
        let urlString = "\(foreCastUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: urlString)
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
            let name = decodedData.name
            let temp = decodedData.main.temp
            let wind = decodedData.wind
            let date = Date().dateString()
            let timeString = Date().timeString()
            
            

            var rain = 0.0
            if let rainData = decodedData.rain {
                rain = (rainData.oneHour != nil ? rainData.oneHour : rainData.threeHour) ?? 0.0
            }
            return WeatherModel(conditionId: id, cityName: name, temp: temp, wind: wind, rain: rain, date: date, time: timeString)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    func performRequests(urlString: String) {
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
    
    func parseForecastJSON(_ forecastData: Data) -> [WeatherModel]? {
        let decoder = JSONDecoder()
        do {
            var forecasts = [WeatherModel]()
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            
            decodedData.list.forEach { forecast in
                let id = forecast.weather[0].id
                let name = forecast.city.name
                let temp = forecast.main.temp
                let wind = forecast.wind
                let date = forecast.dt_txt
                let timeString = forecast.dt_txt
                let rain = (forecast.rain?.threeHour ?? forecast.rain?.oneHour) ?? 0.0
                
                let forecast = WeatherModel(conditionId: id, cityName: name, temp: temp, wind: wind, rain: rain, date: date, time: timeString)
                forecasts.append(forecast)
            }
            return forecasts
                        
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
    
}
