//
//  ViewSpecificController.swift
//  WeatherApp
//
//  Created by Михаил Курис on 07.03.2022.
//

import UIKit

protocol ViewSpecificController {
    associatedtype RootView: UIView
}

extension ViewSpecificController where Self: UIViewController {
    func view() -> RootView {
        return self.view as! RootView
    }
}
