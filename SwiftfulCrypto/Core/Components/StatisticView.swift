//
//  StatisticView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI

struct StatisticView: View {
    // MARK: - Properties
    let statistic: StatisticModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        .degrees((statistic.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            } //: HStack
            .foregroundStyle(
                (statistic.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red
            )
            .opacity(statistic.percentageChange == nil ? 0 : 1)
        } //: VStack
    }
}

// MARK: - Preview
struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(statistic: dev.stat1)
                .previewDisplayName("Stat1")
            StatisticView(statistic: dev.stat2)
                .previewDisplayName("Stat2")
            StatisticView(statistic: dev.stat3)
                .preferredColorScheme(.dark)
                .previewDisplayName("Stat3")
        }
    }
}
