//
//  CitiesRequest.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

private enum Constants {

    static let requestLimit = "1"
}

public struct CitiesRequest: Request {

    let cityName: String
    
    var path: String {
        
        return "geo/1.0/direct"
    }

    var method: HTTPMethod {

        return .get
    }

    var parameters: RequestParams? {

        return .URL(["q": self.cityName,
                     "limit": Constants.requestLimit])
    }
}
