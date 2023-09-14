//
//  RequestProtocol.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

enum HTTPMethod: String {

    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum RequestParams {

    case URL(_ : [String: Any]?)
}

protocol Request {

    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams? { get }
}
