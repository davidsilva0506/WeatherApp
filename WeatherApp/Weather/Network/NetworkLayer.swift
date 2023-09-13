//
//  NetworkLayer.swift
//  Weather
//
//  Created by David Silva on 12/09/2023.
//

import Foundation

public enum NetworkError: Error {

    case invalidURL
    case invalidData
    case requestFailed
    case parsingFailed
    case noInternet
}

private protocol NetworkLayerProtocol {

    var session: URLSession { get }
    func execute<T: Codable>(type: T.Type, request: Request) async throws -> T
}

class NetworkLayer: NetworkLayerProtocol {
    
    private let networkConfig: NetworkConfig
    fileprivate let session: URLSession
    
    init(networkConfig: NetworkConfig) {
        
        self.networkConfig = networkConfig
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func execute<T>(type: T.Type, request: Request) async throws -> T where T: Decodable  {
        
        let URLRequest = try await self.buildURLRequest(for: request)
        
        let (data, response) = try await self.session.data(for: URLRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {

            throw NetworkError.requestFailed
        }

        do {

            let decoder = JSONDecoder()

            return try decoder.decode(type, from: data)

        } catch {

            throw NetworkError.parsingFailed
        }
    }
}

private extension NetworkLayer {
    
    private func buildURLRequest(for request: Request) async throws -> URLRequest {

        let urlString = "\(self.networkConfig.baseUrl)/\(request.path)"
        
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        
        if case .url(let params) = request.parameters {
            
            guard let params = params as? [String: String] else { throw NetworkError.invalidData }
            
            let queryItems: [URLQueryItem] = params.map { param in
                
                return URLQueryItem(name: param.key, value: param.value)
            }
            
            guard var components = URLComponents(string: urlString) else { throw NetworkError.invalidData }
            
            components.queryItems = queryItems
            urlRequest.url = components.url
        }
        
        guard let absoluteURLString = urlRequest.url?.absoluteString,
              var components = URLComponents(string: absoluteURLString) else {
         
            throw NetworkError.invalidData
        }

        var currentQueryItems = components.queryItems ?? [URLQueryItem]()
        currentQueryItems.append(URLQueryItem(name: "appid", value: self.networkConfig.apiKey))
        components.queryItems = currentQueryItems
        urlRequest.url = components.url
        urlRequest.httpMethod = request.method.rawValue

        return urlRequest
    }
}
