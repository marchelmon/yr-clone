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
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.1, alpha: 0.8)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Bermuda"
        return label
    }()
    
    let degreesLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8075824873, green: 0.187832036, blue: 0.1575775297, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "10ºC"
        return label
    }()
    
    let weatherIcon = UIImageView()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSeparators()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWeatherCell() {
        guard let weather = weather else { return }
        
        textLabel?.text = nil
        getLocationButton.removeFromSuperview()
        if weatherIcon.image != nil { weatherIcon.image = nil }

        let imgConfig = UIImage.SymbolConfiguration(pointSize: 45)
        weatherIcon.image = weather.conditionIcon?.withRenderingMode(.alwaysOriginal).withConfiguration(imgConfig)
                
        locationLabel.text = weather.city.name
        degreesLabel.text = weather.tempString
        
        addSubview(locationLabel)
        locationLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
    
        addSubview(weatherIcon)
        weatherIcon.centerY(inView: self)
        weatherIcon.anchor(right: rightAnchor, paddingRight: 15)
        
        addSubview(degreesLabel)
        degreesLabel.centerY(inView: self)
        degreesLabel.anchor(right: weatherIcon.leftAnchor, paddingRight: 5)
        
    }
    
    func configureGetLocation() {
        weatherIcon.image = nil
        degreesLabel.removeFromSuperview()
        
        addSubview(getLocationButton)
        getLocationButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func createFirstRowLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }
    
    func addSeparators() {
        
        let overLine = UIView()
        let underLine = UIView()
        
        overLine.backgroundColor = .lightGray
        underLine.backgroundColor = .lightGray
        
        addSubview(overLine)
        overLine.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 1)
        
        addSubview(underLine)
        underLine.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
    }
}