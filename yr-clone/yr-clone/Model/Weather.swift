//
//  Weather.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-20.
//

import Foundation

//MARK: - WeatherModel

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let wind: Wind
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

//MARK: - WeahterData

struct WeatherData: Decodable {
//    let name: String
//    let main: Main
    let weather: [Weather]
//    let wind: Wind
//    let rain: Rain
    //let dt_txt: String
}

struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let description: String
    let id: Int
}
struct Wind: Codable {
    let speed: Double
    let gust: Double
    let deg: Int
}
struct Rain: Codable {
    let perThreeHours: Double
}
