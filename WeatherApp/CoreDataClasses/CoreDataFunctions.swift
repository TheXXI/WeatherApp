//
//  CoreDataFunctions.swift
//  WeatherApp
//
//  Created by Михаил Курис on 14.03.2022.
//

import UIKit
import Foundation

class CoreDataFunctions {
    
    public static var shared = CoreDataFunctions()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //private var coords = [CoordsEntity]()
    
    public func getAllCoords() -> [CoordsEntity] {
        var coords = [CoordsEntity]()
        do {
            coords = try context.fetch(CoordsEntity.fetchRequest())
        } catch {
            
        }
        return coords
    }
    
    public func addCoord(name: String, lat: Double, lon: Double, nameRu: String, state: String, country: String) {
        let newElement = CoordsEntity(context: context)
        newElement.name = name
        newElement.lat = lat
        newElement.lon = lon
        newElement.nameRu = nameRu
        newElement.state = state
        newElement.country = country
        do {
            try context.save()
        } catch {
            
        }
    }
    
    public  func deleteCoord(element: CoordsEntity) {
        context.delete(element)
        do {
            try context.save()
        } catch {
            
        }
    }
}
