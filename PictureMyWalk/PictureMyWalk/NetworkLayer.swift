//
//  NetworkLayer.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 26.07.22.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        }
    }
}

protocol NetworkLayerProtocol {
    func perform<T: Decodable>(_ request: URLRequest, responseModel: T.Type) async -> Result<T, NetworkError>
}

class NetworkLayer: NetworkLayerProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform<T: Decodable>(_ request: URLRequest, responseModel: T.Type) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await urlSession.data(for: request)
            
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
