//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 8.12.24.
//

import SwiftUI

struct CoinImageView: View {
    // MARK: - Properties
    @StateObject private var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: .init(coin: coin))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CoinImageView(coin: DeveloperPreview.shared.coin)
}
