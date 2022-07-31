//
//  StartView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var viewModel: ImageStreamViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Start my Walk") {
            viewModel.startLocationUpdates()
            dismiss()
        }
        .buttonStyle(.bordered)
    }
}
