//
//  Service.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit

class Service {
    
    static let shared = Service()
        
    let settingRows: [SettingsRow]
    
    let startData = ["Table", "Sky", "Graph"]
    let tempData = ["Celsius", "Fahrenheit"]
    let windData = ["Meters per second (m/s)", "Knots (k/t)", "Kilmoeters per hour (km/h)", "Imperial miles per hour (mph)", "Beaufort (B)"]
    let lengthData = ["Meters", "Feet"]
    let languageData = ["English", "Svenska"]
    let notificationsData = ["Get a short summary of the weather"]
    let mainLocationData = ["Location-based forecast", "Saved location"]

    init() {
        let sunIcon = UIImage(systemName: "sun.max")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let tempIcon = UIImage(systemName: "thermometer.sun")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let windIcon = UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let lengthIcon = UIImage(systemName: "ruler")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let languageIcon = UIImage(systemName: "globe")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let bellIcon = UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let mainLocationIcon = UIImage(systemName: "stopwatch")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        
        settingRows = [
            SettingsRow(withSettingType: .start, text: "Start page", selectionText: startData[0], icon: sunIcon, hasArrow: true),
            SettingsRow(withSettingType: .temp, text: "Temperature", selectionText: tempData[0], icon: tempIcon, hasArrow: true),
            SettingsRow(withSettingType: .wind, text: "Wind", selectionText: windData[0], icon: windIcon, hasArrow: true),
            SettingsRow(withSettingType: .length, text: "Length", selectionText: lengthData[0], icon: lengthIcon, hasArrow: true),
            SettingsRow(withSettingType: .language, text: "Language", selectionText:languageData[0], icon: languageIcon, hasArrow: true),
            SettingsRow(withSettingType: .notifications, text: "Notifications", selectionText: notificationsData[0], icon: bellIcon, hasArrow: true),
            SettingsRow(withSettingType: .mainLocation, text: "Default location", selectionText: mainLocationData[0], icon: mainLocationIcon, hasArrow: true)
        ]
    }
    
    func getSettingData(fromType type: SettingType) -> [String] {
        switch type {
        case .start: return startData
        case .temp: return tempData
        case .wind: return windData
        case .length: return lengthData
        case .language: return languageData
        case .notifications: return notificationsData
        case .mainLocation: return mainLocationData
        case .locationBased: return ["Type with switch location based"]
        }
    }
    
    func getItemFromSettingData(withType type: SettingType, withIndex index: Int) -> String {
        
        switch type {
        case .start: return startData[index]
        case .temp: return tempData[index]
        case .wind: return windData[index]
        case .length: return lengthData[index]
        case .language: return languageData[index]
        case .notifications: return notificationsData[index]
        case .mainLocation: return mainLocationData[index]
        case .locationBased: return "Location based, no data"
        }
    }
    
}
