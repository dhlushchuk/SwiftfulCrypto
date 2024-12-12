//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 11.12.24.
//

import SwiftUI
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    let coin: CoinModel
    private var coinDetailSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedCoinDetails in
                    self?.coinDetails = returnedCoinDetails
                    self?.coinDetailSubscription?.cancel()
                }
            )
    }
    
}
