//
//  ForecastRequest.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

private enum Constants {

    static let requestLimit = "1"
}

public struct ForecastRequest: Request {

    let city: City
    let units: String
    
    var path: String {
        
        return "data/2.5/forecast"
    }

    var method: HTTPMethod {

        return .get
    }

    var parameters: RequestParams? {

        return .URL(["lat": String(self.city.lat),
                     "lon": String(self.city.lon),
                     "units": self.units])
    }
}
