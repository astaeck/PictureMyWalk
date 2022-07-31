//
//  LocationService.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 31.07.22.
//

import Foundation
import CoreLocation

typealias LocationCompletionBlock = ((CLLocation) -> Void)

protocol LocationProvider {
    var isUserAuthorized: Bool { get }
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationProvider {
    var isUserAuthorized: Bool {
        return authorizationStatus == .authorizedAlways
    }
}

class LocationService: NSObject {
    
    private let locationManager: CLLocationManager
    var locationCompletionBlock: ((CLLocation) -> Void)?
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        
        super.init()
        
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.activityType = .fitness
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = CLLocationDistance(100)
        locationManager.delegate = self
    }
    
    func startUpdatingLocation(completion: @escaping ((CLLocation) -> Void)) {
        locationCompletionBlock = completion
        if locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationCompletionBlock?(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager did fail with error: ", error)
    }
}
