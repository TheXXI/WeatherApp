//
//  StringExtension.swift
//  WeatherApp
//
//  Created by Михаил Курис on 18.03.2022.
//

import Foundation

extension String {
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String {
        return self.removingPercentEncoding!
    }
}
