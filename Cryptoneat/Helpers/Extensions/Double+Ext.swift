//
//  Double+Ext.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 6/10/21.
//

import Foundation

extension Double {
    func formatCurrency() -> String {
        let price = self
       
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 10
        
        let priceString = formatter.string(from: price as NSNumber)
        
        return priceString ?? "0"
    }

}
