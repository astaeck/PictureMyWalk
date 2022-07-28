//
//  NetworkLayer.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 26.07.22.
//

import Foundation

protocol NetworkLayerProtocol {
    func perform<T: Decodable>(endpoint: Endpoint, requestParameter: [URLQueryItem]?, responseModel: T.Type) async -> Result<T, NetworkError>
}

class NetworkLayer: NetworkLayerProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform<T: Decodable>(endpoint: Endpoint,
                               requestParameter: [URLQueryItem]? = nil,
                               responseModel: T.Type) async -> Result<T, NetworkError> {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.defaultParameters
        if let requestParameter = requestParameter {
            components.queryItems?.append(contentsOf: requestParameter)
        }

        guard let url = components.url else { return .failure(.invalidURL) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return .failure(.responseUnsuccessful)
            }
            
            guard let decoded: T = try? JSONDecoder().decode(responseModel, from: data) else {
                return .failure(.jsonParsingFailure)
            }
            return .success(decoded)
        }
        catch {
            return .failure(.requestFailed)
        }
    }
}
