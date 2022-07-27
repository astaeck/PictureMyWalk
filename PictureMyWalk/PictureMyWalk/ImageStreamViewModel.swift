//
//  ImageStreamViewModel.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

@MainActor
final class ImageStreamViewModel: ObservableObject {
    @Published var photos = [Photo]()
    private let photoSearchService: PhotoSearchService = PhotoSearchService()
    
    func loadImages() async {
        self.photos = await photoSearchService.photos(with: "2", latitude: "43.613157", longitude: "-8.150246")
    }
}
