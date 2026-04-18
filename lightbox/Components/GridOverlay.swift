//
//  GridOverlay.swift
//  lightbox
//
//  Created by Steve Bass on 2/8/26.
//

import SwiftUI

/// A grid overlay view for aligning negatives
struct GridOverlay: View {
    // MARK: - Properties

    let spacing: Double

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // Draw vertical lines
                var x: Double = 0
                while x <= width {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                    x += spacing
                }

                // Draw horizontal lines
                var y: Double = 0
                while y <= height {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                    y += spacing
                }
            }
            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.white
        GridOverlay(spacing: 50)
    }
}
