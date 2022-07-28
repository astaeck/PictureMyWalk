//
//  PhotoSearchService.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 26.07.22.
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
                //                                      URLQueryItem(name: "geo_context", value: geoContext),
                //                                      URLQueryItem(name: "lat", value: latitude),
                //                                      URLQueryItem(name: "lon", value: longitude),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1")]
    }
    
}

class PhotoSearchService {
    let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol = NetworkLayer()) {
        self.networkLayer = networkLayer
    }
    
    func photos(with geoContext: String,
                      latitude: String,
                      longitude: String) async -> [Photo] {
        
        let parameters = [URLQueryItem(name: "geo_context", value: geoContext),
                          URLQueryItem(name: "lat", value: latitude),
                          URLQueryItem(name: "lon", value: longitude)]

        let result = await networkLayer.perform(endpoint: PhotoSearchEndpoint.getPhotoIDs,
                                                requestParameter: parameters,
                                                responseModel: PhotoContainer.self)
        
        switch result {
        case .success(let photos):
            return photos.photos.photo
        case .failure:
            return []
        }
    }
}
