//
//  FavoriteCell.swift
//  yr-clone
//
//  Created by marchelmon on 2021-06-28.
//

import UIKit


class FavoriteCell: UITableViewCell {
    
    //MARK: - Properties

    var weather: WeatherModel? {
        didSet {
            guard weather != nil else { return }
            configureWeatherCell()
        }
    }

    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.1, alpha: 0.8)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Bermuda"
        return label
    }()

    let degreesLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8075824873, green: 0.187832036, blue: 0.1575775297, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "10ºC"
        return label
    }()

    let weatherIcon = UIImageView()
    
    let starImage = UIImage(systemName: "star")?.withTintColor(.lightGray).withRenderingMode(.alwaysOriginal)
    let fillStarImage = UIImage(systemName: "star.fill")?.withTintColor(.link).withRenderingMode(.alwaysOriginal)
    
    lazy var starIcon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(fillStarImage, for: .normal)
        return button
    }()
    

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
        
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 35)
        weatherIcon.image = weather.conditionIcon?.withRenderingMode(.alwaysOriginal).withConfiguration(imgConfig)
                
        locationLabel.text = weather.city.name
        degreesLabel.text = weather.tempString
        
        addSubview(locationLabel)
        locationLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)

        
        
        addSubview(weatherIcon)
        weatherIcon.centerY(inView: self)
        weatherIcon.anchor(right: rightAnchor, paddingRight: 15)
        
        addSubview(degreesLabel)
        degreesLabel.centerY(inView: self)
        degreesLabel.anchor(right: weatherIcon.leftAnchor, paddingRight: 5)
        
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
    
    func pressedStart(wasAddedToFavorites: Bool) {
        starIcon.imageView?.image = nil
        starIcon.imageView?.image = wasAddedToFavorites ? fillStarImage : starImage
//        if wasAddedToFavorites {
//            starIcon.setImage(fillStarImage, for: .normal)
//        } else {
//            starIcon.setImage(starImage, for: .normal)
//        }
    }
    
}

