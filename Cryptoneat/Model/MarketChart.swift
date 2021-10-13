//
//  MarketChart.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 20/9/21.
//

import Foundation

class MarketChart: Codable {
    
    var timestamp: TimeInterval
    var price: Double
    
    internal init(timestamp: TimeInterval, price: Double) {
        self.timestamp = timestamp
        self.price = price
    }
}



