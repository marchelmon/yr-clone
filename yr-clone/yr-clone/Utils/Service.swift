//
//  Service.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit

struct Service {
    
    static let shared = Service()
    
    let sunIcon = UIImageView(image: UIImage(systemName: "sun.max")?.withRenderingMode(.alwaysOriginal))
    let tempIcon = UIImageView(image: UIImage(systemName: "thermometer")?.withRenderingMode(.alwaysOriginal))
    let windIcon = UIImageView(image: UIImage(systemName: "wind")?.withRenderingMode(.alwaysOriginal))
    let lengthIcon = UIImageView(image: UIImage(systemName: "ruler")?.withRenderingMode(.alwaysOriginal))
    let languageIcon = UIImageView(image: UIImage(systemName: "globe")?.withRenderingMode(.alwaysOriginal))
    let bellIcon = UIImageView(image: UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal))
    let mainLocationIcon = UIImageView(image: UIImage(systemName: "stopwatch")?.withRenderingMode(.alwaysOriginal))
    
    let settingRows: [SettingsRow]
    
    init() {
        settingRows = [
            SettingsRow(text: "Start page", icon: sunIcon, hasArrow: true),
            SettingsRow(text: "Temperature", icon: tempIcon, hasArrow: true),
            SettingsRow(text: "Wind", icon: windIcon, hasArrow: true),
            SettingsRow(text: "Length", icon: lengthIcon, hasArrow: true),
            SettingsRow(text: "Language", icon: languageIcon, hasArrow: true),
            SettingsRow(text: "Notifications", icon: bellIcon, hasArrow: true),
            SettingsRow(text: "Temperature", icon: mainLocationIcon, hasArrow: true)
        ]
    }
    
}
