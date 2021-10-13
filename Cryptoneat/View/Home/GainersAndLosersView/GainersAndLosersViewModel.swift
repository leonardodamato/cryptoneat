//
//  GainersAndLosersViewModel.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 7/10/21.
//

import Foundation

struct GainersAndLosersViewModel {
    var markets: [Market]?

    
    init(markets: [Market]?) {
        self.markets = markets
    }
    
    
    var gainers: [Market] {
        guard let markets = markets else { return [] }
        return markets.sorted(by: { $0.priceChangePercentage24h! > $1.priceChangePercentage24h! })
    }
    
    var losers: [Market] {
        guard let markets = markets else { return [] }
        return markets.sorted(by: { $0.priceChangePercentage24h! < $1.priceChangePercentage24h! })
    }
    
    var segmentedControlItems: [String] {
        return ["Gainers", "Losers"]
    }
}
    
