//
//  Endpoint.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 28.07.22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var defaultParameters: [URLQueryItem] { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "flickr.com"
    }
    
    var apiKey: String {
        return "42727f6e4b4f3d02dddeceaf9df3fca1"
    }
}
