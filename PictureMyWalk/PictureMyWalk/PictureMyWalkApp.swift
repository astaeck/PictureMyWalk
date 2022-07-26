//
//  PictureMyWalkApp.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

@main
struct PictureMyWalkApp: App {
    @State private var showingSheet = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: $showingSheet) {
                    StartView()
                }
        }
    }
}
