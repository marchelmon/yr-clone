//
//  SettingsCell.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-16.
//

import UIKit


class SettingsCell: UITableViewCell {
    
    var settingsRow: SettingsRow? {
        didSet {
            configureCell()
        }
    }
    var cellLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var iconImage = UIImageView()
    
    private let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureCell() {
        guard let data = settingsRow else { return }
        
        cellLabel.text = data.text
        iconImage = data.icon
        
        addSubview(iconImage)
        iconImage.centerY(inView: self)
        
        addSubview(cellLabel)
        
        
        
    }
    
}
