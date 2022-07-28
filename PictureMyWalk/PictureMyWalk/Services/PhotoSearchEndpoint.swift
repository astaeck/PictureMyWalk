//
//  PhotoSearchEndpoint.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 28.07.22.
//

import Foundation

enum PhotoSearchEndpoint: Endpoint {
    
    case getPhotoIDs
    
    var path: String {
        return "/services/rest"
    }
    
    var method: String {
        return "GET"
    }
    
    var defaultParameters: [URLQueryItem] {
        return [URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1")]
    }
    
}
