//
//  Weather.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-20.
//

import UIKit

//MARK: - WeatherModel

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temp: Double
    let wind: Wind
    let rain: Double
    let date: String
    let time: String
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var rainString: String {
        return String(format: "%.1f", rain)
    }
    
    var conditionIcon: UIImage? {
        switch conditionId {
        case 200...232:
            return UIImage(systemName: "cloud.bolt")
        case 300...321:
            return UIImage(systemName: "cloud.drizzle")
        case 500...531:
            return UIImage(systemName: "cloud.rain")
        case 600...622:
            return UIImage(systemName: "cloud.snow")
        case 701...781:
            return UIImage(systemName: "cloud.fog")
        case 800:
            return UIImage(systemName: "sun.max")
        case 801...804:
            return UIImage(systemName: "cloud.bolt")
        default:
            return UIImage(systemName: "cloud")
        }
    }
    
    var windDirectionIcon: UIImage? {
        switch wind.deg {
        case 0...23, 338...360:
            return UIImage(systemName: "arrow.up")
        case 24...69:
            return UIImage(systemName: "arrow.up.right")
        case 70...105:
            return UIImage(systemName: "arrow.right")
        case 106...150:
            return UIImage(systemName: "arrow.down.right")
        case 151...196:
            return UIImage(systemName: "arrow.down")
        case 197...242:
            return UIImage(systemName: "arrow.down.left")
        case 243...288:
            return UIImage(systemName: "arrow.left")
        case 289...337:
            return UIImage(systemName: "arrow.up.left")
        default:
            return UIImage(systemName: "circle")
        }
    }
}

//MARK: - WeahterData

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let rain: Rain?
    let dt_txt: String?
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
    let threeHour: Double?
    let oneHour: Double?
    
    private enum CodingKeys : String, CodingKey {
        case threeHour = "3h"
        case oneHour = "1h"
    }
}



