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
            SettingsRow(withSettingType: .start, text: "Start page", selectionText: "Table", icon: sunIcon, hasArrow: true),
            SettingsRow(withSettingType: .temp, text: "Temperature", selectionText: "Celsius", icon: tempIcon, hasArrow: true),
            SettingsRow(withSettingType: .wind, text: "Wind", selectionText: "m/s meter per second", icon: windIcon, hasArrow: true),
            SettingsRow(withSettingType: .length, text: "Length", selectionText: "meters", icon: lengthIcon, hasArrow: true),
            SettingsRow(withSettingType: .language, text: "Language", selectionText: "English", icon: languageIcon, hasArrow: true),
            SettingsRow(withSettingType: .notifications, text: "Notifications", selectionText: "Off", icon: bellIcon, hasArrow: true),
            SettingsRow(withSettingType: .mainLocation, text: "Default location", selectionText: "GPS based", icon: mainLocationIcon, hasArrow: true)
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
        case .locationBased: print("Type with switch location based")
        }
        return ["No data found"]
    }
    
}
