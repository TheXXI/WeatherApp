//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Михаил Курис on 11.03.2022.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Private properties
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let listButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        return button
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
        addSubview(locationLabel)
        addSubview(listButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            locationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            
            listButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            listButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        ])
    }
    
    // MARK: - Public methods
    
    public func configure (location: String) {
        locationLabel.text = location
    }
}
