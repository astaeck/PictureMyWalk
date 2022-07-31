//
//  UserLocationServiceProtocol.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 01.08.22.
//

import Foundation
import CoreLocation

typealias LocationCompletionBlock = ((CLLocation?, LocationError?) -> Void)

enum LocationError: Swift.Error {
    case canNotBeLocated
}

protocol UserLocationServiceProtocol {
    func startUpdatingLocation(completion: @escaping LocationCompletionBlock)
    func stopUpdatingLocation()
}
