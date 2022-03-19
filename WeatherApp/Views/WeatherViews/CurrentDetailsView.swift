//
//  CurrentDetailsView.swift
//  WeatherApp
//
//  Created by Михаил Курис on 12.03.2022.
//

import UIKit

class CurrentDetailsView: UIView {
    
    // MARK: - Private properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
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
        addSubview(titleLabel)
        addSubview(valueLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
    }
    
    // MARK: - Public methods
    
    public func configure (title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    public func setTitle () {
        titleLabel.text = "Information for today"
        titleLabel.font = UIFont.systemFont(ofSize: 24.0)
        
    }
}
