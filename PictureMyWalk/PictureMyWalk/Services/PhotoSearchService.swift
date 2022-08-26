//
//  PhotoSearchService.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 26.07.22.
//

import Foundation

protocol PhotoSearchServiceProtocol {
    func photos(withLatitude latitude: Double,
                longitude: Double) async -> [Photo]
}

class PhotoSearchService: PhotoSearchServiceProtocol {
    let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol = NetworkLayer()) {
        self.networkLayer = networkLayer
    }
    
    @MainActor
    func photos(withLatitude latitude: Double,
                longitude: Double) async -> [Photo] {
        
        let parameters = [URLQueryItem(name: "lat", value: "\(latitude)"),
                          URLQueryItem(name: "lon", value: "\(longitude)")]
        
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
