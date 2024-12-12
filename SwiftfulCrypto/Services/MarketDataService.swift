//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI
import Combine

class MarketDataService {
    @Published var marketData: MarketDataResponse.MarketDataModel? = nil
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: MarketDataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedGlobal in
                    self?.marketData = returnedGlobal.data
                    self?.marketDataSubscription?.cancel()
                }
            )
    }
    
}
