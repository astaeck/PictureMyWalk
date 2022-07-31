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
    
    private let photoSearchService: PhotoSearchServiceProtocol
    private let locationManager: CLLocationManager
    
    init(photoSearchService: PhotoSearchServiceProtocol = PhotoSearchService(),
         locationManager: CLLocationManager = CLLocationManager()) {
        self.photoSearchService = photoSearchService
        self.locationManager = locationManager
        
        super.init()
        setUpLocationManager()
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    @MainActor
    private func loadLocationPhotos() {
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
    
    private func setUpLocationManager() {
        self.locationManager.requestAlwaysAuthorization()

        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.activityType = .fitness

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = CLLocationDistance(100)
        locationManager.delegate = self
    }
}

extension ImageStreamViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
            self.loadLocationPhotos()
        }
    }
}
