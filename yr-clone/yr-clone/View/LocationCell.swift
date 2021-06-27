//
//  LocationCell.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-27.
//

import UIKit


class LocationCell: UITableViewCell {
    
    //MARK: - Properties
    
    var weather: WeatherModel? {
        didSet {
            if weather != nil {
                configureWeatherCell()
            } else {
                configureGetLocation()
            }
        }
    }
    
    private let getLocationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.link)
        button.setImage(image, for: .normal)
        button.setTitle(" Get Location ", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7689752871, green: 1, blue: 0.9971108456, alpha: 1).withAlphaComponent(0.2)
        button.isEnabled = false
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("Initted cell")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWeatherCell() {
        
    }
    
    func configureGetLocation() {
    
        addSubview(getLocationButton)
        getLocationButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
    }
    
    
    
}
