//
//  CoordsEntity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Михаил Курис on 14.02.2022.
//
//

import Foundation
import CoreData

extension CoordsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordsEntity> {
        return NSFetchRequest<CoordsEntity>(entityName: "CoordsEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
    @NSManaged public var nameRu: String?
    @NSManaged public var state: String?

}

extension CoordsEntity: Identifiable {

}
