//
//  Market.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 16/9/21.
//

import Foundation

class Market: Codable {

    var id: String
    var symbol: String
    var name: String
    var image: String?
    var currentPrice: Double?
    var marketCap: Int?
    var marketCapRank: Int?
    var fullyDilutedValuation: Int?
    var totalVolume: Double?
    var high24h: Double?
    var low24h: Double?
    var priceChange24h: Double?
    var priceChangePercentage24h: Double?
    var marketCapChange24h: Double?
    var marketCapChangePercentage24h: Double?
    var circulatingSupply: Double?
    var totalSupply: Double?
    var maxSupply: Double?
    var ath: Double?
    var athChangePercentage: Double?
    var athDate: String?
    var atl: Double?
    var atlChangePercentage: Double?
    var atlDate: String?
    var lastUpdated: String?
    var priceChangePercentage24hInCurrency: Double?
    
    
    internal init(id: String, symbol: String, name: String, image: String? = nil, currentPrice: Double? = nil, marketCap: Int? = nil, marketCapRank: Int? = nil, fullyDilutedValuation: Int? = nil, totalVolume: Double? = nil, high24h: Double? = nil, low24h: Double? = nil, priceChange24h: Double? = nil, priceChangePercentage24h: Double? = nil, marketCapChange24h: Double? = nil, marketCapChangePercentage24h: Double? = nil, circulatingSupply: Double? = nil, totalSupply: Double? = nil, maxSupply: Double? = nil, ath: Double? = nil, athChangePercentage: Double? = nil, athDate: String? = nil, atl: Double? = nil, atlChangePercentage: Double? = nil, atlDate: String? = nil, lastUpdated: String? = nil, priceChangePercentage24hInCurrency: Double? = nil) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCapRank = marketCapRank
        self.fullyDilutedValuation = fullyDilutedValuation
        self.totalVolume = totalVolume
        self.high24h = high24h
        self.low24h = low24h
        self.priceChange24h = priceChange24h
        self.priceChangePercentage24h = priceChangePercentage24h
        self.marketCapChange24h = marketCapChange24h
        self.marketCapChangePercentage24h = marketCapChangePercentage24h
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.ath = ath
        self.athChangePercentage = athChangePercentage
        self.athDate = athDate
        self.atl = atl
        self.atlChangePercentage = atlChangePercentage
        self.atlDate = atlDate
        self.lastUpdated = lastUpdated
        self.priceChangePercentage24hInCurrency = priceChangePercentage24hInCurrency
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        
        
     }
}


