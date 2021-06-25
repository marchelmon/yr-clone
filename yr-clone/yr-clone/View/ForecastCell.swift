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
        label.textColor = #colorLiteral(red: 0.8075824873, green: 0.187832036, blue: 0.1575775297, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "10ºC"
        return label
    }()
    
    let rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .link
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "4 m/s"
        label.textColor = UIColor(white: 0.1, alpha: 0.9)
        return label
    }()
    
    let weatherIcon = UIImageView()
    let windIcon = UIImageView()
    
    //MARK: - Lifecycle
    
    
    //MARK: - Helpers
    
    
    func configureCell() {
        selectionStyle = .none
        guard let weather = weather else { return }
        
        if weatherIcon.image != nil { weatherIcon.image = nil }
        if windIcon.image != nil { windIcon.image = nil }
        
        weatherIcon.image = weather.conditionIcon?.withRenderingMode(.alwaysOriginal)
        windIcon.image = weather.windDirectionIcon?.withTintColor(UIColor(white: 0.1, alpha: 0.9)).withRenderingMode(.alwaysOriginal)
        
        //let weatherIcon = UIImageView(image: weather.conditionIcon?.withTintColor(.black).withRenderingMode(.alwaysOriginal))
        //let windIcon = UIImageView(image: weather.windDirectionIcon?.withTintColor(.black).withRenderingMode(.alwaysOriginal))
        
        hoursLabel.text = getHourString(fromHour: weather.date.getHour())
        degreesLabel.text = weather.tempString
        if weather.rain != 0.0 { rainLabel.text = weather.rainString }
        windLabel.text = weather.windString

        
        addSubview(hoursLabel)
        hoursLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
        hoursLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(weatherIcon)
        weatherIcon.centerY(inView: self, leftAnchor: hoursLabel.rightAnchor, paddingLeft: 20)
        
        addSubview(degreesLabel)
        degreesLabel.centerY(inView: self, leftAnchor: weatherIcon.rightAnchor, paddingLeft: 25)
        
        contentView.addSubview(windIcon)
        windIcon.centerY(inView: self)
        windIcon.anchor(right: rightAnchor, paddingtRight: 15)
        
        addSubview(windLabel)
        windLabel.centerY(inView: self)
        windLabel.anchor(right: windIcon.leftAnchor, paddingtRight: 8)
        
        addSubview(rainLabel)
        rainLabel.centerY(inView: self)
        rainLabel.centerX(inView: self, constant: 60)
        
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
