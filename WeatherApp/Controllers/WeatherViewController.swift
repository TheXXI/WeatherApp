//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 07.03.2022.
//

import UIKit

class WeatherViewController: UIViewController, ViewSpecificController {
typealias RootView = WeatherView
    
    // MARK: - Private properties
    public var coord: CoordsEntity?
    
    // MARK: - Private properties
    private var weather: WeatherData?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*ApiManager.shared.getWeather(latCoord: coord!.lat, lonCoord: coord!.lon, completion: {result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let weather):
                            print(weather)
                        case .failure(let error):
                            print(error)
                        }
                    }
                })*/
        
        view().backgroundColor = .white
        
    }
    
    override func loadView() {
        self.view = WeatherView()
        
    }

}
