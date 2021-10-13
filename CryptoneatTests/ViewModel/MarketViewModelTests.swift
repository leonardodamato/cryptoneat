//
//  MarketViewModelTests.swift
//  CryptoneatTests
//
//  Created by Leonardo D'Amato on 21/9/21.
//

import XCTest
@testable import Cryptoneat

class MarketViewModelTests: XCTestCase {
    let mockMarket = Market(id: "", symbol: "", name: "")
    
    func testFormatNumberWithMaximumTwoDecimalPlaces() {
        let viewModel = MarketViewModel(market: mockMarket)
        
        let number: Double = 2.486734
        let expectedNumberString: String = "2.49"
        
        let finalNumberString = viewModel.formatNumberWithMaximumTwoDecimalPlaces(for: number as NSNumber)
        
        XCTAssertEqual(finalNumberString, expectedNumberString)
        
    }
    
    
    func testFormatCurrency() {
        let viewModel = MarketViewModel(market: mockMarket)
        
        let number = 23434.94
        let expectedCurrencyString = "$23,434.94"
        let finalCurrencyString = viewModel.formatCurrency(for: number)
        
        XCTAssertEqual(finalCurrencyString, expectedCurrencyString)
    }
    
    
    func testFormatLongDate() {
        let viewModel = MarketViewModel(market: mockMarket)
        
        let dateString = "2021-09-16T02:20:14.229Z"
        let expectedDateString = "16 September 2021"
        let finalDateString = viewModel.formatLongDate(for: dateString)
        
        XCTAssertEqual(finalDateString, expectedDateString)
    }

}
