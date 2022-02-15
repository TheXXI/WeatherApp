//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Михаил Курис on 08.02.2022.
//

import Foundation

enum ApiType {
    
    case coords (city: String)
    case weather (latCoord: Double, lonCoord: Double)
    
    var request: URLRequest {
        switch self {
        case .coords(city: let city):
            let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=" + city  + "&appid=abe768f4f95a06831a1056b7b93f3d3f")
            let request = URLRequest(url: url!)
            return request
        case .weather(latCoord: let latCoord, lonCoord: let lonCoord):
            let stringLatCoord = String(format: "%.7f", latCoord)
            let stringLonCoord = String(format: "%.7f", lonCoord)
            let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=" + stringLatCoord + "&lon=" + stringLonCoord + "&exclude=minutely,alerts&appid=abe768f4f95a06831a1056b7b93f3d3f&units=metric")
            let request = URLRequest(url: url!)
            return request
    
        }
    
    }
    
}
    
enum ApiError: Error {
    case noData
}

class ApiManager {
    
    static var shared = ApiManager()
    
    func getCoords (city: String, completion: @escaping (Result<Coords, Error>) -> Void) {
        let request = ApiType.coords(city: city).request
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Coords.self, from: data)
                completion(.success(response))
                print("getCoords: success")
            } catch let error {
                print(error)
                completion(.failure(error))
                print("getCoords: error")
            }
        }
        task.resume()
    }
    
    func getWeather (latCoord: Double, lonCoord: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let request = ApiType.weather(latCoord: latCoord, lonCoord: lonCoord).request
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(WeatherData.self, from: data)
                completion(.success(response))
                print("getWeather: success")
            } catch let error {
                print(error)
                completion(.failure(error))
                print("getWeather: error")
            }
            
        }
        task.resume()
    }
    
}
