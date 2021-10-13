//
//  MarketsViewModel.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 16/9/21.
//

import UIKit
import CoreData

class MarketViewModel {
    
    var market: Market
    
    init(market: Market) {
        self.market = market
    }
    
    ///Interval array to be used on the Segmented Control at MarketChartViewController
    ///
    let intervalArray = [
        "24h",
        "7d",
        "15d",
        "30d",
        "90d",
        "180d",
        "1y",
        "Max"
    ]
    
    ///Price Change Percentage 24h
    ///
    var priceChangePercentage24h: String {
        let pct = market.priceChangePercentage24h ?? 0
        let numberString = String(format: "%.2f", pct)
        let finalString = pct >= 0 ? "+\(numberString)%" : "\(numberString)%"
        
        return finalString
    }
    
    ///Check if the price change percentage 24h is positive or negative
    ///
    var isPriceChangePercentage24hPositive: Bool {
        let pct = market.priceChangePercentage24h ?? 0
        return pct >= 0
    }
    
    
    ///Defines the text color for price change percentage 24h depending on whether the value is positive or negative
    ///Positive: Green
    ///Negative: Red
    ///
    var priceChangePercentage24hColor: UIColor {
        return market.priceChangePercentage24h ?? 0 >= 0 ? .systemGreen : .systemRed
    }
    
    
    ///Get current price string correctly formated for a market
    ///
    var currentPrice: String {
        let price = market.currentPrice ?? 0
       
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 10
        
        let priceString = formatter.string(from: price as NSNumber)
        
        return priceString!
    }
    
    
    ///This function creates a string with a maximum of two decimal places. We decided to use NSNumber as parameter because we can have the same function for INT and DOUBLE types
    ///Input: 298592348.2394234 Expected return: 298,592,348.24
    ///Input: 238947 Expected return: 238,947
    ///
    func formatNumberWithMaximumTwoDecimalPlaces(for number: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        
        let number = formatter.string(from: number)
        
        return number ?? "Error"
    }
    
    
    ///Format currency string using US format (In the future when we accept the user to change their currency, this function will change to support all currencies supported on the app)
    ///Correct format: "$23,443.04"
    ///
    func formatCurrency(for number: Double) -> String {
        let price = number
       
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 10
        
        let priceString = formatter.string(from: price as NSNumber)
        
        return priceString ?? "0"
    }
    
    ///Returns string: "20 january 2020"
    ///
    func formatLongDate(for dateString: String) -> String {
        let date = dateString.iso8601withFractionalSeconds
        
        guard let unwrappedDate = date else { return "Error" }
        
        let finalFormatter = DateFormatter()
        finalFormatter.dateFormat = "dd MMMM yyyy"
        let finalDateString = finalFormatter.string(from: unwrappedDate)
        
        return finalDateString
    }
    
    
    //MARK: - Favorites Section
    let favoritesViewModel = FavoritesViewModel()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    ///Check if the user has the market on their favorites
    ///
    var isFavorite: Bool {
        let favorites = favoritesViewModel.fetchFavorites()
        return favorites.contains(market.id)
    }
    
    
    func addToFavorites(completion: (Bool) -> ()) {
        var success: Bool = false
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)
        let favorite = NSManagedObject(entity: entity!, insertInto: context)
        favorite.setValue(market.id, forKey: "id")
        
        do {
            try context.save()
            success = true
            completion(success)
            
        } catch {
            //TODO: - Handle errors
            success = false
            completion(success)
            print(error.localizedDescription)
        }
    }
    
    
     func removeFromFavorites(completion: (Bool) -> ()) {
        var success: Bool = false
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "id = %@", market.id)
        
        do {
            
            let fetch = try context.fetch(fetchRequest)
            let idToDelete = fetch[0] as! NSManagedObject
            context.delete(idToDelete)
            
            do {
                try context.save()
                success = true
                completion(success)
            } catch  {
                success = false
                completion(success)
                print(error.localizedDescription)
            }
            
        } catch  {
            success = false
            completion(success)
            print(error.localizedDescription)
        }
    }
}
