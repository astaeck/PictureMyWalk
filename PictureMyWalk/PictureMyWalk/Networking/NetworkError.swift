//
//  NetworkError.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 28.07.22.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case responseUnsuccessful
    case jsonParsingFailure
    case invalidURL

    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .invalidURL: return "Invalid URL"
        }
    }
}
