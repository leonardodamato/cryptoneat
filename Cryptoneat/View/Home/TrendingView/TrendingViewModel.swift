//
//  TrendingViewModel.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 6/10/21.
//

import Foundation
import SDWebImage

struct TrendingViewModel {
    
    var coin: Item?
    
    var title: String {
        return "Trending"
    }
    
    var source: String {
        return "Source: CoinGecko"
    }
    
    var image: UIImageView {
        guard let coin = coin else { return UIImageView() }
        let url = URL(string: coin.small)
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "dollarsign.circle"))
        
        return imageView
    }
    
    
    var name: String {
        guard let coin = coin else { return "" }
        return coin.name
    }
    
    
    var symbol: String {
        guard let coin = coin else { return "" }
        return coin.symbol
    }
    
    
    func getMarketImage(for urlString: String) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        let url = URL(string: urlString)
        
        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "dollarsign.circle"))
        
        return imageView
    }
    
    
    func getTrendingCoins(completion: @escaping (Result<Trending, Error>) -> Void) {
        let service = MarketsService()
        
        service.getTrendingMarkets { (result) in
            switch result {
            case .success(let trending):
                completion(.success(trending))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
