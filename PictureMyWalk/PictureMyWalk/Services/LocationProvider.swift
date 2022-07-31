//
//  LocationProvider.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 01.08.22.
//

import Foundation
import CoreLocation

protocol LocationProvider {

    var isUserAuthorized: Bool { get }
    var pausesLocationUpdatesAutomatically: Bool { get set }
    var allowsBackgroundLocationUpdates: Bool { get set }
    var showsBackgroundLocationIndicator: Bool { get set }
    var activityType: CLActivityType { get set }
    
    var desiredAccuracy: CLLocationAccuracy { get set }
    var distanceFilter: CLLocationDistance { get set }
    var delegate: CLLocationManagerDelegate? { get set }

    func requestAlwaysAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
