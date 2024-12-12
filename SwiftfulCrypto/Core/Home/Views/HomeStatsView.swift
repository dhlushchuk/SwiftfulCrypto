//
//  HomeStatsView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI

struct HomeStatsView: View {
    // MARK: - Properties
    @Binding var showPortfolio: Bool
    @EnvironmentObject private var vm: HomeViewModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        } //: HStack
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: showPortfolio ? .trailing : .leading
        )
    }
}

// MARK: - Preview
#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.shared.homeVM)
}
