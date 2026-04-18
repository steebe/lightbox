//
//  LightboxViewModel.swift
//  Lightbox
//
//  Created by Steve Bass on 2/8/26.
//

import Foundation
import Combine

/// ViewModel managing the state and business logic for the Lightbox
final class LightboxViewModel: ObservableObject {
    // MARK: - Published Properties

    /// Whether the lightbox is currently active (showing bright light)
    @Published var isLightActive: Bool = false

    /// Current brightness level (0.3 to 1.0)
    @Published var brightness: Double = 1.0

    /// Whether the alignment grid is visible
    @Published var showGrid: Bool = false

    /// Spacing between grid lines in points
    @Published var gridSpacing: Double = 50.0

    /// Whether the controls panel is visible
    @Published var showControls: Bool = true

    // MARK: - Constants

    let minBrightness: Double = 0.3
    let maxBrightness: Double = 1.0
    let minGridSpacing: Double = 25.0
    let maxGridSpacing: Double = 100.0
    let gridSpacingStep: Double = 5.0

    /// Dimming factor applied when controls are visible (60% of selected brightness)
    private let controlsDimmingFactor: Double = 0.6

    // MARK: - Actions

    /// Activates the lightbox
    func activateLightbox() {
        isLightActive = true
    }

    /// Deactivates the lightbox and returns to landing screen
    func deactivateLightbox() {
        isLightActive = false
    }

    /// Toggles the controls panel visibility
    func toggleControls() {
        showControls.toggle()
    }

    /// Toggles the alignment grid
    func toggleGrid() {
        showGrid.toggle()
    }

    // MARK: - Computed Properties

    /// Actual brightness to display (dimmed when controls are visible)
    var displayBrightness: Double {
        showControls ? brightness * controlsDimmingFactor : brightness
    }

    /// Returns brightness as a percentage string
    var brightnessPercentage: String {
        "\(Int(brightness * 100))%"
    }

    /// Returns grid spacing as a formatted string
    var gridSpacingText: String {
        "\(Int(gridSpacing))pt"
    }
}
