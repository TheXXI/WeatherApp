//
//  Coords.swift
//  WeatherApp
//
//  Created by Михаил Курис on 08.02.2022.
//
//  let coords = try? newJSONDecoder().decode(Coords.self, from: jsonData)

import Foundation

// MARK: - Coord
struct Coord: Codable {
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

typealias Coords = [Coord]
