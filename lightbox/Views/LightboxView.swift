//
//  LightboxView.swift
//  Lightbox
//
//  Created by Steve Bass on 2/8/26.
//

import SwiftUI

/// Main lightbox view with bright background and controls
struct LightboxView: View {
    
    @ObservedObject var viewModel: LightboxViewModel

    var body: some View {
        ZStack {
            background
            gridOverlay
            controlsOverlay
        }
    }

    private var background: some View {
        Color.white
            .brightness(viewModel.displayBrightness - 1.0)
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.3), value: viewModel.showControls)
    }

    @ViewBuilder
    private var gridOverlay: some View {
        if viewModel.showGrid {
            GridOverlay(spacing: viewModel.gridSpacing)
                .ignoresSafeArea()
        }
    }

    private var controlsOverlay: some View {
        VStack {
            if viewModel.showControls {
                ControlsPanel(viewModel: viewModel)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding()
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

            Spacer()

            bottomButtons
        }
    }

    private var bottomButtons: some View {
        HStack {
            deactivateButton

            Spacer()

            toggleControlsButton
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    }

    private var deactivateButton: some View {
        Button(action: viewModel.deactivateLightbox) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 32))
                .foregroundColor(.primary)
                .padding()
        }
    }

    private var toggleControlsButton: some View {
        Button(action: viewModel.toggleControls) {
            Image(systemName: viewModel.showControls ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                .font(.system(size: 32))
                .foregroundColor(.primary)
                .padding()
        }
    }
}

#Preview {
    LightboxView(viewModel: LightboxViewModel())
}
