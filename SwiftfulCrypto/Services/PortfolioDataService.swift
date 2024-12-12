//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI
import SwiftData

class PortfolioDataService {
    @Published var savedItems: [Portfolio] = []
    private let container: ModelContainer
    private let context: ModelContext
    
    init() {
        self.container = try! ModelContainer(for: Portfolio.self)
        self.context = ModelContext(container)
        self.getPortfolio()
    }
    
    // MARK: - PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let item = savedItems.first(where: { $0.id == coin.id }) {
            if amount > 0 {
                update(item: item, amount: amount)
            } else {
                delete(item: item)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE
    private func getPortfolio() {
        do {
            savedItems = try context.fetch(FetchDescriptor<Portfolio>())
        } catch {
            print("Error fetching Portfolio. \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let item = Portfolio(id: coin.id, amount: amount)
        context.insert(item)
        applyChanges()
    }
    
    private func update(item: Portfolio, amount: Double) {
        item.amount = amount
        applyChanges()
    }
    
    private func delete(item: Portfolio) {
        context.delete(item)
        applyChanges()
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Error saving to SwiftData. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
