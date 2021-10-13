//
//  GainersLosersCell.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 8/10/21.
//

import UIKit

class GainersLosersCell: UITableViewCell {
        
    var container: UIView!
    
    var symbolLabel:UILabel!
    
    var priceLabel: UILabel!
    var priceChange24hLabel: UILabel!
    
    
    override func prepareForReuse() {
        container.removeFromSuperview()
    }
    
    
    func configure(with market: Market) {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        configureContainer()
        
        configureSymbolLabel(with: market)
        
        configurePriceChange24hLabel(with: market)
        configurePriceLabel(with: market)
    }
    
    
    func configureContainer() {
        container = UIView()
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    
    func configureSymbolLabel(with market: Market) {
        symbolLabel = UILabel()
        container.addSubview(symbolLabel)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        
        symbolLabel.text = market.symbol.uppercased()
        symbolLabel.font = UIFont.boldSystemFont(ofSize: 16)
        symbolLabel.textColor = Colors.tint
        
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            symbolLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            symbolLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
    }
    
    
    func configurePriceLabel(with market: Market) {
        let viewModel = MarketViewModel(market: market)
        
        priceLabel = UILabel()
        container.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.text = viewModel.currentPrice
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.textColor = Colors.secondary
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -85),
            priceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
    }
    
    func configurePriceChange24hLabel(with market: Market) {
        let viewModel = MarketViewModel(market: market)
        
        priceChange24hLabel = UILabel()
        container.addSubview(priceChange24hLabel)
        priceChange24hLabel.translatesAutoresizingMaskIntoConstraints = false
                
        priceChange24hLabel.text = viewModel.priceChangePercentage24h
        priceChange24hLabel.font = UIFont.systemFont(ofSize: 16)
        priceChange24hLabel.textColor =  viewModel.priceChangePercentage24hColor
        
        NSLayoutConstraint.activate([
            priceChange24hLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            priceChange24hLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            priceChange24hLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
    }
}
