//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 8.12.24.
//

import SwiftUI

struct CircleButtonView: View {
    // MARK: - Properties
    let iconName: String
    let callback: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            callback()
        } label: {
            Image(systemName: iconName)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .foregroundStyle(Color.theme.background)
                )
                .shadow(color: Color.theme.accent.opacity(0.25), radius: 10)
                .padding()
        }
    }
}

// MARK: - Preview
#Preview("Light") {
    CircleButtonView(iconName: "info") {}
}

#Preview("Dark") {
    CircleButtonView(iconName: "plus") {}
        .preferredColorScheme(.dark)
}
