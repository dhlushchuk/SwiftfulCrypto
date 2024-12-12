//
//  CoinLogoView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI

struct CoinLogoView: View {
    // MARK: - Properties
    let coin: CoinModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Preview
struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin)
                .previewDisplayName("Light")
            CoinLogoView(coin: dev.coin)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
    }
}
