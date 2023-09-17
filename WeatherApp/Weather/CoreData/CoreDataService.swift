//
//  CoreDataService.swift
//  Weather
//
//  Created by David Silva on 15/09/2023.
//

import Foundation
import CoreData

private enum Constants {

    static let containerName = "Cities"
    static let loadAssertionMessage = "Failed to load core data with error:"
    static let saveAssertionMessage = "Failed to save the data with error:"
}

final class CoreDataService: ObservableObject {
    
    static let shared = CoreDataService()

    let container = NSPersistentContainer(name: Constants.containerName)
    
    init() {
        
        self.container.loadPersistentStores { _, error in
            
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error {
                
                assertionFailure("\(Constants.loadAssertionMessage)\(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        
        do {
            
            try context.save()
            
        } catch {
            
            assertionFailure("\(Constants.saveAssertionMessage)\(error.localizedDescription)")
        }
    }
    
    func addCityDetail(city: City, context: NSManagedObjectContext) {
        
        let newCityDetail = CityDetail(context: context)
        
        newCityDetail.name = city.name
        newCityDetail.lat = city.lat
        newCityDetail.lon = city.lon
        newCityDetail.country = city.country
        
        self.save(context: context)
    }
}
