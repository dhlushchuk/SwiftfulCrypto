//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI

struct XMarkButton: View {
    // MARK: - Properties
    let callback: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            callback()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

// MARK: - Preview
#Preview {
    XMarkButton() {}
}
