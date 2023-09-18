//
//  CitiesRequest.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

private enum Constants {

    static let requestLimit = "1"
    static let path = "geo/1.0/direct"
    static let cityParamKey = "q"
    static let limitParamKey = "limit"
}

public struct CitiesRequest: Request {

    let cityName: String
    
    var path: String {
        
        return Constants.path
    }

    var method: HTTPMethod {

        return .get
    }

    var parameters: RequestParams? {

        return .URL([Constants.cityParamKey: self.cityName,
                     Constants.limitParamKey: Constants.requestLimit])
    }
}
