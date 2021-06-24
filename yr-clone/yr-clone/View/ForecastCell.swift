//
//  ForecastCell.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-24.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    //MARK: - Properties
    
    var weather: WeatherModel? {
        didSet {
            configureCell()
        }
    }
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0000"
        return label
    }()
    
    let degreesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "10ºC"
        return label
    }()
    
    let rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .link
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0.1mm"
        return label
    }()
    
    let windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "4 m/s"
        return label
    }()
    
    let iconView: UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    //MARK: - Lifecycle
    
    
    //MARK: - Helpers
    
    func configureCell() {
        selectionStyle = .none
        
        guard let weather = weather else { return }
        
        let weatherIcon = UIImageView(image: weather.conditionIcon)
        let windIcon = UIImageView(image: weather.windDirectionIcon)
        
        hoursLabel.text = getHourString(fromHour: weather.date.getHour())
        degreesLabel.text = weather.tempString
        rainLabel.text = weather.rainString
        windLabel.text = weather.windString

        
        addSubview(hoursLabel)
        hoursLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)
        hoursLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(weatherIcon)
        weatherIcon.centerY(inView: self, leftAnchor: hoursLabel.rightAnchor, paddingLeft: 20)
        
        addSubview(degreesLabel)
        degreesLabel.centerY(inView: self, leftAnchor: weatherIcon.rightAnchor, paddingLeft: 20)
        
        addSubview(windIcon)
        windIcon.centerY(inView: self)
        windIcon.anchor(right: rightAnchor, paddingtRight: 15)
        
        addSubview(windLabel)
        windLabel.centerY(inView: self)
        windLabel.anchor(right: windIcon.leftAnchor, paddingLeft: 5)
        
        addSubview(rainLabel)
        rainLabel.centerY(inView: self)
        rainLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60).isActive = true
        
    }
    
    
    func getHourString(fromHour hour: Int) -> String {
        
        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
        
        var upcomingHourString = (hour + 3) < 10 ? "0\(hour + 3)" : "\(hour + 3)"
        
        if (hour + 3) > 24 {
            upcomingHourString = "0\(hour - 21)"
        }
        
        return "\(hourString)-\(upcomingHourString)"
    }
    
}
