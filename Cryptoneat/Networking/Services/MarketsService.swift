//
//  MarketsService.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import UIKit

struct MarketsService {
    
    typealias getMarketsCompletion = (Result<[Market], Error>) -> Void
    typealias getMarketChartCompletion = (Result<[MarketChart], Error>) -> Void
    typealias getTrendingMarketsCompletion = (Result<Trending, Error>) -> Void


    func getSomeMarkets(markets: [String], completion: @escaping getMarketsCompletion) {
        let api = API()
        
        let marketsString = markets.joined(separator: ",")
        
        let parameters = [
            "vs_currency" : "usd",
            "ids" : marketsString,
            "order" : "market_cap_desc",
            "per_page" : "200",
            "page" : "1",
            "sparkline" : "false",
            "price_change_percentage" : "24h",
        ]

        let url = api.createUrl(for: .markets, with: parameters)

        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }

            if let data = data {
                let decoder = JSONDecoder()
                let decodedData = try! decoder.decode([Market].self, from: data)

                completion(.success(decodedData))
            }
        }

        task.resume()
    }
    
    
    
    func getMarkets(page: Int, perPage: Int, completion: @escaping getMarketsCompletion) {
        let api = API()
        
        let parameters = [
            "vs_currency" : "usd",
            "order" : "market_cap_desc",
            "per_page" : String(perPage),
            "page" : String(page),
            "sparkline" : "false",
            "price_change_percentage" : "24h",
        ]

        let url = api.createUrl(for: .markets, with: parameters)

        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }

            if let data = data {
                let decoder = JSONDecoder()
                //decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
                let decodedData = try! decoder.decode([Market].self, from: data)

                completion(.success(decodedData))
            }
        }

        task.resume()
    }
    
    
    func getMarketChart(for market: Market, days: String, completion: @escaping getMarketChartCompletion) {
        let api = API()
        
        let parameters = [
            "vs_currency" : "usd",
            "days" : days
        ]

        let url = api.createMarketChartUrl(for: market, with: parameters)

        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }

            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                let prices = json!["prices"] as! [[Double]]
                
                var result: [MarketChart] = []
                
                for price in prices {
                    let chart = MarketChart(timestamp: price[0], price: price[1])
                    result.append(chart)
                }
                
                completion(.success(result))
            }
        }

        task.resume()
    }
    
    
    func getTrendingMarkets(completion: @escaping getTrendingMarketsCompletion) {
        let api = API()
        let url = api.createUrl(for: .trending)
        
        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                let decodedData = try! decoder.decode(Trending.self, from: data)
                completion(.success(decodedData))
            }
        }
        
        task.resume()
    }
}
