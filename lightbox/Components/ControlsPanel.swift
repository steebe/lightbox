//
//  ControlsPanel.swift
//  lightbox
//
//  Created by Steve Bass on 2/8/26.
//

import SwiftUI

/// Panel containing brightness and grid controls
struct ControlsPanel: View {
    // MARK: - Properties

    @ObservedObject var viewModel: LightboxViewModel

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            header
            brightnessControl
            gridControls
        }
        .padding()
    }

    // MARK: - Subviews

    private var header: some View {
        HStack {
            Text("Lightbox")
                .font(.headline)
            Spacer()
        }
    }

    private var brightnessControl: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "sun.max.fill")
                Text("Brightness")
                Spacer()
                Text(viewModel.brightnessPercentage)
                    .foregroundColor(.secondary)
            }
            Slider(
                value: $viewModel.brightness,
                in: viewModel.minBrightness...viewModel.maxBrightness
            )
        }
    }

    private var gridControls: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "grid")
                Text("Alignment Grid")
                Spacer()
                Toggle("", isOn: $viewModel.showGrid)
                    .labelsHidden()
            }

            if viewModel.showGrid {
                gridSpacingControl
            }
        }
    }

    private var gridSpacingControl: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "arrow.left.and.right")
                Text("Grid Spacing")
                Spacer()
                Text(viewModel.gridSpacingText)
                    .foregroundColor(.secondary)
            }
            Slider(
                value: $viewModel.gridSpacing,
                in: viewModel.minGridSpacing...viewModel.maxGridSpacing,
                step: viewModel.gridSpacingStep
            )
        }
    }
}

// MARK: - Preview

#Preview {
    ControlsPanel(viewModel: LightboxViewModel())
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding()
}
