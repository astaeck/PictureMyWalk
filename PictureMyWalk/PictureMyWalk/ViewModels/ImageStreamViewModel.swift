//
//  ImageStreamViewModel.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI
import CoreLocation

final class ImageStreamViewModel: NSObject, ObservableObject {
    @Published var photos: [Photo] = []
    
    private let photoSearchService: PhotoSearchServiceProtocol
    private let locationService: UserLocationServiceProtocol
    
    init(photoSearchService: PhotoSearchServiceProtocol = PhotoSearchService(),
         locationService: UserLocationServiceProtocol = UserLocationService()) {
        self.photoSearchService = photoSearchService
        self.locationService = locationService
        
        super.init()
    }
    
    func startLocationUpdates() {
        locationService.startUpdatingLocation { [weak self] location, error in
            guard let self = self else { return }
            if error == nil {
                DispatchQueue.main.async {
                    self.loadLocationPhotosWith(location)
                }
            } else {
                print("Location was not updated")
            }
        }
    }
    
    func stopLocationUpdates() {
        locationService.stopUpdatingLocation()
    }
    
    @MainActor
    private func loadLocationPhotosWith(_ location: CLLocation?) {
        guard let location = location else { return }
        
        Task {
            var newPhotos = await photoSearchService.photos(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            while true {
                guard let newPhoto = newPhotos.first else { return }
                if photos.contains(where: { $0.id == newPhoto.id }) {
                    newPhotos.removeFirst()
                } else {
                    photos.insert(newPhoto, at: 0)
                    return
                }
            }
        }
    }
}
