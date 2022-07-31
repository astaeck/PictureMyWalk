//
//  ImageStreamViewModelTests.swift
//  PictureMyWalkTests
//
//  Created by Angelina Staeck on 31.07.22.
//

import XCTest
import CoreLocation
@testable import PictureMyWalk

class ImageStreamViewModelTests: XCTestCase {
    
    var sut: ImageStreamViewModel!
    var locationService: LocationServiceMock!
    var photoSearchService: PhotoSearchServiceMock!
    
    override func setUp() {
        super.setUp()
        locationService = LocationServiceMock()
        photoSearchService = PhotoSearchServiceMock()
        sut = ImageStreamViewModel(photoSearchService: photoSearchService,
                                   locationService: locationService)
    }
    
    override func tearDown() {
        sut = nil
        locationService = nil
        photoSearchService = nil
        super.tearDown()
    }
    
    func testStartLocationUpdates_Authorized_ShouldReturnUserLocation() {
        sut.startLocationUpdates()
        
        XCTAssertTrue(locationService.isLocationUpdateReceived)
    }
    
}

class LocationServiceMock: UserLocationServiceProtocol {
    var location: CLLocation? = CLLocation(
        latitude: 37.3317,
        longitude: -122.0325086
    )
    var isLocationUpdateReceived = false
    
    func startUpdatingLocation(completion: @escaping LocationCompletionBlock) {
        completion(location, nil)
        isLocationUpdateReceived = true
    }
    
    func stopUpdatingLocation() {}
}

class PhotoSearchServiceMock: PhotoSearchServiceProtocol {
    var photos = [Photo(id: "123", secret: "456", server: "7")]
    
    func photos(withLatitude latitude: Double, longitude: Double) async -> [Photo] {
        return photos
    }
}
