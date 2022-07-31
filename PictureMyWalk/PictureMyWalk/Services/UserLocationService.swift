//
//  UserLocationService.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 31.07.22.
//

import Foundation
import CoreLocation

extension CLLocationManager: LocationProvider {

    var isUserAuthorized: Bool {
        return authorizationStatus == .authorizedAlways
    }
}

class UserLocationService: NSObject, UserLocationServiceProtocol {
    
    private var provider: LocationProvider
    var locationCompletionBlock: LocationCompletionBlock?
    
    init(provider: LocationProvider = CLLocationManager()) {
        self.provider = provider
        
        super.init()
        
        self.provider.pausesLocationUpdatesAutomatically = false
        self.provider.allowsBackgroundLocationUpdates = true
        self.provider.showsBackgroundLocationIndicator = true
        self.provider.activityType = .fitness
        
        self.provider.desiredAccuracy = kCLLocationAccuracyBest
        self.provider.distanceFilter = CLLocationDistance(100)
    }
    
    func startUpdatingLocation(completion: @escaping LocationCompletionBlock) {
        self.provider.delegate = self
        locationCompletionBlock = completion
        if provider.isUserAuthorized {
            provider.startUpdatingLocation()
        } else {
            provider.requestAlwaysAuthorization()
        }
    }
    
    func stopUpdatingLocation() {
        provider.stopUpdatingLocation()
    }
}

extension UserLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            provider.startUpdatingLocation()
        } else {
            print("Location services are not enabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationCompletionBlock?(location, nil)
        } else {
            locationCompletionBlock?(nil, .canNotBeLocated)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager did fail with error: ", error)
    }
}
