//
//  PortfolioModel.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI
import SwiftData

@Model
final class Portfolio {
    
    @Attribute(.unique) var id: String
    var amount: Double
    
    init(id: String, amount: Double) {
        self.id = id
        self.amount = amount
    }
    
}
