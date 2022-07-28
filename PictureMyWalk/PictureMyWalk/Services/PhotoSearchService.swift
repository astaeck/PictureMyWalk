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
