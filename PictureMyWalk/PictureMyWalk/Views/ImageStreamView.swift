//
//  ImageStreamView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ImageStreamView: View {
    @StateObject private var viewModel = ImageStreamViewModel()
    
    var body: some View {
        List(viewModel.photos, id: \.id) { item in
            Text(item.id)
        }
        .listStyle(.plain)
    }
    
}
