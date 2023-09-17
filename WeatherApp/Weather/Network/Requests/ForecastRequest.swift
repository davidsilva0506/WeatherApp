//
//  ForecastRequest.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

private enum Constants {

    static let path = "data/2.5/forecast"
    static let latParamKey = "lat"
    static let lonParamKey = "lon"
    static let unitsParamKey = "units"
}

public struct ForecastRequest: Request {

    let city: City
    let units: String
    
    var path: String {
        
        return Constants.path
    }

    var method: HTTPMethod {

        return .get
    }

    var parameters: RequestParams? {

        return .URL([Constants.latParamKey: String(self.city.lat),
                     Constants.lonParamKey: String(self.city.lon),
                     Constants.unitsParamKey: self.units])
    }
}
