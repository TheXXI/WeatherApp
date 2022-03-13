//
//  DailyView.swift
//  WeatherApp
//
//  Created by Михаил Курис on 12.03.2022.
//

import UIKit

class DailyView: UIView {
    
    // MARK: - Private properties
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tempNightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempDayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
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
        addSubview(dateLabel)
        addSubview(dayLabel)
        addSubview(weatherIconImageView)
        addSubview(tempNightLabel)
        addSubview(tempDayLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
            dayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            dayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 60),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 60),
            weatherIconImageView.centerXAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            weatherIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            tempNightLabel.widthAnchor.constraint(equalToConstant: 60),
            tempNightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tempNightLabel.rightAnchor.constraint(equalTo: weatherIconImageView.leftAnchor, constant: -5),
            
            tempDayLabel.widthAnchor.constraint(equalToConstant: 60),
            tempDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tempDayLabel.rightAnchor.constraint(equalTo: tempNightLabel.leftAnchor, constant: -20)
        ])
    }
    
    // MARK: - Public methods
    
    public func configure (model: Daily) {
        dateLabel.text = TimeFormatter.getTime(format: "MMM d", unixtime: model.dt!)
        dayLabel.text = TimeFormatter.getTime(format: "EEEE", unixtime: model.dt!)
        weatherIconImageView.image = UIImage(named: model.weather![0].icon!)
        tempNightLabel.text = "\(NumberFormatter.double(number: (model.temp?.day)!)) °C"
        tempDayLabel.text = "\(NumberFormatter.double(number: (model.temp?.night)!))"
    }
    
}
