//
//  SettingsRow.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit

struct SettingsRow {
    let icon: UIImageView
    let text: String
    let hasArrow: Bool
    
    init(text: String, icon: UIImageView, hasArrow: Bool) {
        self.text = text
        self.icon = icon
        self.hasArrow = hasArrow
    }
}
