//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 8.12.24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel?
    @State private var showDetailView: Bool = false
    @State private var showSettingsView: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                } else {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        } else {
                            portfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        } //: ZStack
        .navigationDestination(isPresented: $showDetailView) {
            DetailLoadingView(coin: $selectedCoin)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(DeveloperPreview.shared.homeVM)
}

// MARK: - HomeView extension
extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info") {
                if showPortfolio {
                    showPortfolioView.toggle()
                } else {
                    showSettingsView.toggle()
                }
            }
            .background {
                CircleButtonAnimationView(isAnimating: $showPortfolio)
            }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right") {
                withAnimation(.spring()) {
                    showPortfolio.toggle()
                }
            }
            .rotationEffect(.degrees(showPortfolio ? 180 : 0))
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List(vm.allCoins) { coin in
            CoinRowView(coin: coin, showHoldingsColumn: false)
                .listRowInsets(.init(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 10
                ))
                .listRowBackground(Color.theme.background)
                .onTapGesture {
                    segue(coin: coin)
                }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            vm.reloadData()
        }
    }
    
    private var portfolioCoinsList: some View {
        List(vm.portfolioCoins) { coin in
            CoinRowView(coin: coin, showHoldingsColumn: true)
                .listRowInsets(.init(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 10
                ))
                .listRowBackground(Color.theme.background)
                .onTapGesture {
                    segue(coin: coin)
                }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button to get started. 🧐")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(
                        (vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0
                    )
                    .rotationEffect(.degrees(vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(
                            (vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1 : 0
                        )
                        .rotationEffect(.degrees(vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(
                        (vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1 : 0
                    )
                    .rotationEffect(.degrees(vm.sortOption == .price ? 0 : 180))
            }
            .frame(
                width: UIScreen.main.bounds.width / 3.5,
                alignment: .trailing
            )
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                vm.reloadData()
            } label: {
                Image(systemName: "goforward")
                    .rotationEffect(.degrees(vm.isLoading ? 360 : 0), anchor: .center)
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
}
