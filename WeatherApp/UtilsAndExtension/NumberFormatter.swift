//
//  NumberFormatter.swift
//  WeatherApp
//
//  Created by Михаил Курис on 11.03.2022.
//

import Foundation

class NumberFormatter {
    
    static func double (number: Double) -> NSString {
        if number > 0.5 {
            return NSString(string: "0")
        }
        return NSString(format: "%.0f", round(number))
    }
}
