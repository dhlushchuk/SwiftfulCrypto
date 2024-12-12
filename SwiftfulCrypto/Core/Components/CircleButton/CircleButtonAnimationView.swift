//
//  CircleButtonAnimationView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 8.12.24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    // MARK: - Properties
    @Binding var isAnimating: Bool
    
    // MARK: - Body
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(isAnimating ? 1 : 0)
            .opacity(isAnimating ? 0 : 1)
            .animation(
                isAnimating ? .easeOut(duration: 1) : .none,
                value: isAnimating
            )
    }
}

// MARK: - Preview
#Preview {
    CircleButtonAnimationView(isAnimating: .constant(false))
}
