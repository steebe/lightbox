//
//  ContentView.swift
//  lightbox
//
//  Created by Steve Bass on 2/6/26.
//

import SwiftUI

/// Main content view that coordinates between landing and lightbox screens
struct ContentView: View {

    @StateObject private var viewModel = LightboxViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLightActive {
                LightboxView(viewModel: viewModel)
            } else {
                LandingView(onActivate: viewModel.activateLightbox)
            }
        }
        .animation(.easeInOut, value: viewModel.isLightActive)
        .preferredColorScheme(viewModel.isLightActive ? .light : .dark)
        .statusBar(hidden: viewModel.isLightActive && !viewModel.showControls)
    }
}

#Preview {
    ContentView()
}
