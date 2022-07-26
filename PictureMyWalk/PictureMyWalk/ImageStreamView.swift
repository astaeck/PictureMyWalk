//
//  ImageStreamView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ImageStreamView: View {
    @EnvironmentObject var viewModel: ImageStreamViewModel

    @State private var photos = [Photo]()
    
    var body: some View {
        List(photos, id: \.id) { item in
//            Image(uiImage: image)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .clipped()
//                .cornerRadius(8)
//                .padding(5)
        }
        .task {
            await viewModel.loadImages()
        }
    }
    
}
