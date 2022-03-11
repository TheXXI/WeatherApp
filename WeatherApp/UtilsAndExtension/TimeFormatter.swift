//
//  TimeFormatter.swift
//  WeatherApp
//
//  Created by Михаил Курис on 25.02.2022.
//

import Foundation

class TimeFormatter {
    
    static func getTime (format: String, unixtime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixtime))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+03") // Set timezone that you want
        dateFormatter.locale = NSLocale.current
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = format // Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

}
