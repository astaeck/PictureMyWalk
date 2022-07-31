//
//  ImageStreamView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ImageStreamView: View {
    @EnvironmentObject var viewModel: ImageStreamViewModel

    var body: some View {
        List(viewModel.photos, id: \.id) { photo in
            AsyncImage(
                url: photo.url,
                content: { image in
                    image.resizable()
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 350)
                },
                placeholder: {
                    ProgressView()
                }
            )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
}
