//
//  BitcoinPriceViewModel.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 6/10/21.
//

import Foundation
 
struct BitcoinPriceViewModel {
    let service = MarketsService()
    
    func getBitcoinPrice(completion: @escaping (Result<Market, Error>) -> Void) {
        let bitcoin = ["bitcoin"]
        service.getSomeMarkets(markets: bitcoin) { (result) in
            switch result {
            case .success(let markets):
                let bitcoin = markets[0]
                completion(.success(bitcoin))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
