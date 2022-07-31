//
//  UserLocationServiceTests.swift
//  PictureMyWalkTests
//
//  Created by Angelina Staeck on 31.07.22.
//

import XCTest
import CoreLocation
@testable import PictureMyWalk

class UserLocationServiceTests: XCTestCase {
    var sut: UserLocationService!
    var locationProvider: LocationProviderMock!
    
    override func setUp() {
        super.setUp()
        locationProvider = LocationProviderMock()
        sut = UserLocationService(provider: locationProvider)
    }
    
    override func tearDown() {
        sut = nil
        locationProvider = nil
        super.tearDown()
    }
    
    func testStartUpdatingLocation_NotAuthorized_ShouldRequestAuthorization() {
        locationProvider.isUserAuthorized = false
        
        sut.startUpdatingLocation { _, _ in }
        
        XCTAssertFalse(locationProvider.isStartUpdatingLocationCalled)
        XCTAssertTrue(locationProvider.isRequestWhenInUseAuthorizationCalled)
    }
    
    func testStartUpdatingLocation_Authorized_ShouldNotRequestAuthorization() {
        locationProvider.isUserAuthorized = true
        
        sut.startUpdatingLocation { _, _ in }
        
        XCTAssertFalse(locationProvider.isRequestWhenInUseAuthorizationCalled)
        XCTAssertTrue(locationProvider.isStartUpdatingLocationCalled)
    }
    
    func testStopUpdatingLocation_Authorized_ShouldNotRequestAuthorization() {
        sut.stopUpdatingLocation()
        
        XCTAssertFalse(locationProvider.isRequestWhenInUseAuthorizationCalled)
        XCTAssertFalse(locationProvider.isStartUpdatingLocationCalled)
        XCTAssertTrue(locationProvider.isStopUpdatingLocationCalled)
    }
}

class LocationProviderMock: LocationProvider {
    
    var isRequestWhenInUseAuthorizationCalled = false
    var isStartUpdatingLocationCalled = false
    var isStopUpdatingLocationCalled = false
    var isUserAuthorized: Bool = true

    var pausesLocationUpdatesAutomatically: Bool = true
    var allowsBackgroundLocationUpdates: Bool = true
    var showsBackgroundLocationIndicator: Bool = true
    var activityType: CLActivityType = .fitness
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest
    var distanceFilter: CLLocationDistance = CLLocationDistance(500)
    
    var delegate: CLLocationManagerDelegate?
    
    func requestAlwaysAuthorization() {
        isRequestWhenInUseAuthorizationCalled = true
    }
    func startUpdatingLocation() {
        isStartUpdatingLocationCalled = true
    }
    func stopUpdatingLocation() {
        isStopUpdatingLocationCalled = true
    }
}
