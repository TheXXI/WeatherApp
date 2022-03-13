//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Михаил Курис on 11.03.2022.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherCell"
    
    // MARK: - Private properties
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(timeLabel)
        addSubview(weatherIconImageView)
        addSubview(tempLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 60),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 60),
            weatherIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    public func configure (model: Current) {
        timeLabel.text = TimeFormatter.getTime(format: "HH:mm", unixtime: model.dt!)
        weatherIconImageView.image = UIImage(named: model.weather![0].icon!)
        tempLabel.text = "\(NumberFormatter.double(number: model.temp!)) °C"
    }
}
