//
//  ContentView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ContentView: View {
    private let viewModel: ImageStreamViewModel = ImageStreamViewModel()
    
    var body: some View {
        ImageStreamView()
            .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
