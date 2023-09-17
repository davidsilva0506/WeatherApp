//
//  ImageRequest.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

private enum Constants {
    
    static let path = "img/w"
}

public struct ImageRequest: Request {

    let icon: String
    
    var path: String {
        
        return "\(Constants.path)/\(icon)"
    }

    var method: HTTPMethod {

        return .get
    }

    var parameters: RequestParams? {

        return nil
    }
}
