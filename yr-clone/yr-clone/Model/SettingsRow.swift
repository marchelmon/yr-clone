//
//  SettingsRow.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit


enum SettingType: CustomStringConvertible {
    case start
    case temp
    case wind
    case length
    case language
    case notifications
    case locationBased
    case mainLocation
    
    
    var description: String {
        switch self {
        case .start:
            print("Start")
        case .temp:
            print("Temp")
        case .wind:
            print("wind")
        case .length:
            print("lenght")
        case .language:
            print("lang")
        case .notifications:
            print("nitoce")
        case .locationBased:
            print("LBased")
        case .mainLocation:
            print("main location")
        }
        return "snopp SettingType"
    }
    
    
}

struct SettingsRow {
    let icon: UIImage?
    let text: String
    let selectionText: String
    let hasArrow: Bool
    
    init(text: String, selectionText: String, icon: UIImage?, hasArrow: Bool) {
        self.text = text
        self.selectionText = selectionText
        self.icon = icon
        self.hasArrow = hasArrow
    }
}
