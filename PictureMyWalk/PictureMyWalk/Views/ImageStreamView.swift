//
//  ImageStreamView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ImageStreamView: View {
    @EnvironmentObject var viewModel: ImageStreamViewModel
    @State private var didTapButton: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    didTapButton.toggle()
                    didTapButton ? viewModel.stopLocationUpdates() : viewModel.startLocationUpdates()
                }) {
                    Text(didTapButton ? "Start" : "Stop")
                }
                .padding()
                .buttonStyle(.bordered)
            }
            List(viewModel.photos, id: \.id) { photo in
                HStack {
                    Spacer()
                    AsyncImage(
                        url: photo.url,
                        content: { image in
                            image.resizable()
                                .scaledToFit()
                                .clipped()
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 300)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(height: 300)
                        }
                    )
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
            .animation(.default, value: viewModel.photos)
            .listStyle(.plain)
        }
    }
    
}
