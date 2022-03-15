//
//  CurrentView.swift
//  WeatherApp
//
//  Created by Михаил Курис on 11.03.2022.
//

import UIKit

class CurrentView: UIView {
    
    // MARK: - Private properties
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let weatherTextLabel: UILabel = {
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
        addSubview(tempLabel)
        addSubview(feelsLikeLabel)
        addSubview(weatherIconImageView)
        addSubview(weatherTextLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            feelsLikeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            feelsLikeLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            
            weatherIconImageView.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor),
            
            weatherTextLabel.centerYAnchor.constraint(equalTo: weatherIconImageView.centerYAnchor),
            weatherTextLabel.leftAnchor.constraint(equalTo: weatherIconImageView.rightAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    public func configure (model: Current) {
        tempLabel.text = "\(NumberFormatter.double(number: model.temp!)) °C"
        feelsLikeLabel.text = "Ощущается: \(NumberFormatter.double(number: model.feelsLike!)) °C"
        weatherIconImageView.image = UIImage(named: model.weather![0].icon!)
        weatherTextLabel.text = model.weather![0].main
    }
}
