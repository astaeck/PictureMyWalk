//
//  ImageStreamView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ImageStreamView: View {
    @StateObject var viewModel = ImageStreamViewModel()

    var body: some View {
        List(viewModel.photos, id: \.id) { item in
            Text(item.id)
//            Image(uiImage: image)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .clipped()
//                .cornerRadius(8)
//                .padding(5)
        }
        .listStyle(.plain)
        .task {
            await viewModel.loadImages()
        }
    }
    
}
