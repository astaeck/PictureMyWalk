//
//  Photo.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 26.07.22.
//

import Foundation

struct PhotoContainer: Decodable {
    var photos: Photos
}

struct Photos: Decodable {
    var photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let secret: String
    let server: String
}
