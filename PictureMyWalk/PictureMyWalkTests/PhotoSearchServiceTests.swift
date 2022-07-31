//
//  PhotoSearchServiceTests.swift
//  PictureMyWalkTests
//
//  Created by Angelina Staeck on 31.07.22.
//

import XCTest
@testable import PictureMyWalk

class PhotoSearchServiceTests: XCTestCase {
    var sut: PhotoSearchService!
    var networkLayer: NetworkLayerMock!
    
    override func setUp() {
        super.setUp()
        networkLayer = NetworkLayerMock()
        sut = PhotoSearchService(networkLayer: networkLayer)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestPhotos_onSuccess_returnsArrayOfPhotos() async {
        networkLayer.photos = PhotoContainer(photos: Photos(photo: [Photo(id: "123", secret: "456", server: "7")]))

        let photos = await sut.photos(withLatitude: 51.509865, longitude: -0.118092)

        XCTAssertEqual(photos.count, 1)
        XCTAssertEqual(photos.first?.id, "123")
    }
    
    func testRequestPhotos_onFailure_returnsEmptyArrayOfPhotos() async {
        let photos = await sut.photos(withLatitude: 51.509865, longitude: -0.118092)

        XCTAssertTrue(photos.isEmpty)
    }
}

class NetworkLayerMock: NetworkLayerProtocol {
    var photos: PhotoContainer?

    func perform<T>(endpoint: Endpoint, requestParameter: [URLQueryItem]?, responseModel: T.Type) async -> Result<T, NetworkError> where T : Decodable {

        guard let photos = photos else {
            return .failure(NetworkError.requestFailed)
        }
        
        return .success(photos as! T)
    }
}
