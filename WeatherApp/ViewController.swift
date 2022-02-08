//
//  ViewController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 08.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*ApiManager.shared.getCoords(city: "Moscow", completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coord):
                    print(coord)
                case .failure(let error):
                    print("error: \(error)")
                }
            }
            
        })*/
        
        /*ApiManager.shared.getWeather(latCoord: 37.00, lonCoord: 44.00, completion: {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    print(weather)
                case .failure(let error):
                    print(error)
                }
            }
        })*/
    }
    
    func getTime (unixtime: Int) -> String {
        let date = Date(timeIntervalSince1970: 1644309000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+03") // Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
