//
//  Currency.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 16/9/21.
//

import Foundation

class Currency {
    internal init(name: String, code: String, symbol: String) {
        self.name = name
        self.code = code
        self.symbol = symbol
    }
    
    var name: String
    var code: String
    var symbol: String
}
