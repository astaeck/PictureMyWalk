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

struct Photo: Decodable, Equatable {
    let id: String
    let secret: String
    let server: String
    
    var url: URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_w.jpg")!
    }
}
