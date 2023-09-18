//
//  CityDetailNavigationLink.swift
//  Weather
//
//  Created by David Silva on 18/09/2023.
//

import Foundation
import SwiftUI

struct CityDetailNavigationLink: View {
    
    private let service: ServiceLayer
    private let coreDataService: CoreDataService
    private let city: City

    init(service: ServiceLayer,
         coreDataService: CoreDataService,
         city: City) {

        self.service = service
        self.coreDataService = coreDataService
        self.city = city
    }

    var body: some View {
        
        NavigationLink(destination: CityDetailView(service: self.service,
                                                   coreDataService: self.coreDataService,
                                                   city: self.city)) {
                
            Text("\(self.city.name), \(self.city.country)")
                .font(.body)
                .fontWeight(.semibold)
                .scaledToFit()
        }
    }
}
