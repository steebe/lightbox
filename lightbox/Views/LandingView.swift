//
//  LandingView.swift
//  Lightbox
//
//  Created by Steve Bass on 2/8/26.
//

import SwiftUI

/// Landing screen shown before activating the lightbox
struct LandingView: View {
    
    let onActivate: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                icon
                title
                subtitle

                Spacer()

                actionButtons
            }
        }
    }

    private var icon: some View {
        Image(systemName: "light.max")
            .font(.system(size: 80))
            .foregroundColor(.white)
    }

    private var title: some View {
        Text("Lightbox")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }

    private var subtitle: some View {
        Text("A bright home for your negatives")
            .font(.subheadline)
            .foregroundColor(.gray)
    }

    private var actionButtons: some View {
        VStack(spacing: 16) {
            activateButton
            warningText
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 60)
    }

    private var activateButton: some View {
        Button(action: onActivate) {
            HStack {
                Image(systemName: "lightbulb.fill")
                Text("Activate Lightbox")
            }
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(12)
        }
    }

    private var warningText: some View {
        Text("⚠️ Warning: Bright light ahead")
            .font(.caption)
            .foregroundColor(.orange)
    }
}

#Preview {
    LandingView(onActivate: {})
}
