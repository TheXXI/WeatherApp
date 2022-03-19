//
//  CitiesListView.swift
//  WeatherApp
//
//  Created by Михаил Курис on 16.03.2022.
//

import UIKit

class CitiesListView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = UISearchBar.Style.default
        search.placeholder = " Search..."
        search.sizeToFit()
        search.isTranslucent = false
        return search
    }()
    
    let activity = UIActivityIndicatorView()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(tableView)
        addSubview(activity)
        
        setTableViewConstraints()
        setActivityConstraints()
        tableView.tableHeaderView = searchBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add Constraints
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
       ])
    }
    
    private func setActivityConstraints() {
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            activity.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            activity.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            activity.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
       ])
    }
    
}
