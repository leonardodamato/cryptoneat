//
//  API.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import Foundation

enum Endpoint: String {
    case markets = "coins/markets?"
    case trending = "search/trending?"
}

struct API {
    let rootURL = URL(string: "https://api.coingecko.com/api/v3/")!
    
    func createUrl(for endpoint: Endpoint) -> URL {
        let stringURL = "\(rootURL)\(endpoint.rawValue)"
        
        let url = URL(string: stringURL)
        
        return url!
    }
    
    
    func createUrl(for endpoint: Endpoint, with parameters: [String : String]) -> URL {
        var stringURL = "\(rootURL)\(endpoint.rawValue)"
        
        for (key, value) in parameters {
            stringURL += "\(key)=\(value)&"
        }
        
        let url = URL(string: stringURL)
        
        return url!
    }
  
    
    func createMarketChartUrl(for market: Market, with parameters: [String : String]) -> URL {
        var stringURL = "\(rootURL)coins/\(market.id)/market_chart?"
        
        for (key, value) in parameters {
            stringURL += "\(key)=\(value)&"
        }
        
        let url = URL(string: stringURL)
        
        return url!
    }
}
