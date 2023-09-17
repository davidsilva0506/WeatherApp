//
//  CityDetail.swift
//  Weather
//
//  Created by David Silva on 15/09/2023.
//

import Foundation
import CoreData

final class CityDetail: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var country: String
}
