//
//  ContentView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct ContentView: View {
    private let imageStreamViewModel: ImageStreamViewModel = ImageStreamViewModel()
    @State private var showingSheet = true

    var body: some View {
        ImageStreamView()
            .sheet(isPresented: $showingSheet) {
                StartView()
            }
            .environmentObject(imageStreamViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
