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
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    var iconImage: UIImageView =  {
        let iv = UIImageView()
        iv.setDimensions(width: 28, height: 28)
        return iv
    }()
    private let arrowIcon: UIImageView = {
        let image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal)
        let iv = UIImageView(image: image)
        return iv
    }()
    
    var selectionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureCell() {
        guard let data = settingsRow else { return }
        
        cellLabel.text = data.text
        selectionText.text = data.selectionText
        iconImage.image = data.icon
        
        addSubview(iconImage)
        iconImage.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)
        
        let textStack = UIStackView(arrangedSubviews: [cellLabel, selectionText])
        textStack.axis = .vertical
        
        addSubview(textStack)
        textStack.centerY(inView: self, leftAnchor: iconImage.rightAnchor, paddingLeft: 15)

        if data.hasArrow {
            addSubview(arrowIcon)
            arrowIcon.centerY(inView: self)
            arrowIcon.anchor(right: rightAnchor, paddingtRight: 15)
        }

        
        
    }
    
}
