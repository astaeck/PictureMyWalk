//
//  PhotoSearchService.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 26.07.22.
//

import Foundation

class PhotoSearchService {
    let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol = NetworkLayer()) {
        self.networkLayer = networkLayer
    }
    
    var apiKey: String {
        return "42727f6e4b4f3d02dddeceaf9df3fca1"
    }
    
    var base: String {
        return "https://www.flickr.com"
    }
    
    var path: String {
        return "/services/rest"
    }
    
    func photos(with geoContext: String,
                latitude: String,
                longitude: String) async -> [Photo] {
        
        let parameters: [URLQueryItem] = [URLQueryItem(name: "method", value: "flickr.photos.search"),
                                          URLQueryItem(name: "api_key", value: apiKey),
                                          URLQueryItem(name: "geo_context", value: geoContext),
                                          URLQueryItem(name: "lat", value: latitude),
                                          URLQueryItem(name: "lon", value: longitude),
                                          URLQueryItem(name: "format", value: "json"),
                                          URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = parameters
        let url = components.url!
        let urlRequest = URLRequest(url: url)
        
        let result = await networkLayer.perform(urlRequest, responseModel: PhotoContainer.self)
        
        switch result {
        case .success(let photos):
            return photos.photos.photo
        case .failure:
            return []
        }
    }
}
