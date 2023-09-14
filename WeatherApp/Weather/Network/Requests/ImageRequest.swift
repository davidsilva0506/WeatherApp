//
//  ImageRequest.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

public struct ImageRequest: Request {

    let icon: String
    
    var path: String {
        
        return "img/w/\(icon)"
    }

    var method: HTTPMethod {

        return .get
    }

    var parameters: RequestParams? {

        return nil
    }
}
