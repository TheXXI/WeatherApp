//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 07.03.2022.
//

import UIKit

class WeatherViewController: UIViewController, ViewSpecificController {
typealias RootView = WeatherView
    
    // MARK: - Public properties
    
    public var coord: CoordsEntity?
    
    // MARK: - Private properties
    
    private var btnCitesList: UIButton!
    private var weather: WeatherData?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().createHeaderView(location: checkStateAndCity())
        btnCitesList = view().headerView.listButton
        btnCitesList.addTarget(self, action: #selector(btnCitesListAction), for: .touchUpInside)
        loadAndShowWheater()
        
    }
    override func loadView() {
        self.view = WeatherView()
    }
    
    // MARK: - Private methods
    
    private func checkStateAndCity() -> String {
        if coord?.state == coord?.name {
            return "\(coord!.name ?? ""), \(coord!.country ?? "")"
        } else {
            return "\(coord!.name ?? ""), \(coord!.state ?? ""), \(coord!.country ?? "")"
        }
    }

    private func loadAndShowWheater () {
        ApiManager.shared.getWeather(latCoord: coord!.lat, lonCoord: coord!.lon, completion: {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let getweather):
                    self.view().createScrollView(weatherDataModel: getweather)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    // MARK: - Actions
    
    @objc func btnCitesListAction(sender: UIButton!) {
        let rootViewController = CitiesListViewController()
        rootViewController.title = "List of cities"
        let navigationController = UINavigationController(rootViewController: rootViewController)
        present(navigationController, animated: true)
    }
}
