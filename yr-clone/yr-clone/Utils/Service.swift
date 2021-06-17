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

    
    init() {
        
        let sunIcon = UIImage(systemName: "sun.max")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let tempIcon = UIImage(systemName: "thermometer.sun")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let windIcon = UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let lengthIcon = UIImage(systemName: "ruler")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let languageIcon = UIImage(systemName: "globe")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let bellIcon = UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        let mainLocationIcon = UIImage(systemName: "stopwatch")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        
        
        
        settingRows = [
            SettingsRow(text: "Start page", selectionText: "Table", icon: sunIcon, hasArrow: true),
            SettingsRow(text: "Temperature", selectionText: "Celsius", icon: tempIcon, hasArrow: true),
            SettingsRow(text: "Wind", selectionText: "m/s meter per second", icon: windIcon, hasArrow: true),
            SettingsRow(text: "Length", selectionText: "meters", icon: lengthIcon, hasArrow: true),
            SettingsRow(text: "Language", selectionText: "English", icon: languageIcon, hasArrow: true),
            SettingsRow(text: "Notifications", selectionText: "Off", icon: bellIcon, hasArrow: true),
            SettingsRow(text: "Default location", selectionText: "GPS based", icon: mainLocationIcon, hasArrow: true)
        ]
    }
    
    
    
}
