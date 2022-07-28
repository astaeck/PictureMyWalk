//
//  StartView.swift
//  PictureMyWalk
//
//  Created by Angelina Staeck on 25.07.22.
//

import SwiftUI

struct StartView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Start Walk") {
            dismiss()
        }
        .buttonStyle(.bordered)
    }
}
