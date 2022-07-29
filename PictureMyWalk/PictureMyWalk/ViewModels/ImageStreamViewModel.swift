//
//  ImageStreamViewModel.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI
import Foundation
import CoreLocation

final class ImageStreamViewModel: NSObject, ObservableObject {
    @Published var photos: [Photo] = []
    private var location: CLLocation?
    
    private let photoSearchService: PhotoSearchService
    private let locationManager: CLLocationManager
    
    init(photoSearchService: PhotoSearchService = PhotoSearchService(),
         locationManager: CLLocationManager = CLLocationManager()) {
        self.photoSearchService = photoSearchService
        self.locationManager = locationManager
        
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = CLLocationDistance(100)
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
    }
    
    @MainActor
    func locationPhotos() {
        guard let location = location else { return }
        Task {
            let newPhotos = await photoSearchService.photos(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude).prefix(1)
            photos.append(contentsOf: newPhotos)
        }
    }
}

extension ImageStreamViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
            self.locationPhotos()
        }
    }
}
