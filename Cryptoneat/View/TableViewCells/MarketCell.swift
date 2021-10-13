//
//  MarketCell.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import UIKit

class MarketCell: UITableViewCell {
        
    var container: UIView!
    
    var nameStackView: UIStackView!
    var nameLabel: UILabel!
    var symbolLabel:UILabel!
    
    var priceLabel: UILabel!
    var priceChange24hLabel: UILabel!
    
    
    override func prepareForReuse() {
        container.removeFromSuperview()
        nameStackView.removeFromSuperview()
    }
    
    
    func configure(with market: Market) {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        configureContainer()
        
        configureSymbolLabel(with: market)
        configureNameLabel(with: market)
        configureNameStackView()
        
        configurePriceChange24hLabel(with: market)
        configurePriceLabel(with: market)
    }
    
    
    func configureContainer() {
        container = UIView()
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 15
        container.backgroundColor = Colors.bgWithAlpha
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    
    func configureNameLabel(with market: Market) {
        nameLabel = UILabel()
        nameLabel.text = market.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = Colors.secondary
    }
    
    
    func configureSymbolLabel(with market: Market) {
        symbolLabel = UILabel()
        symbolLabel.text = market.symbol.uppercased()
        symbolLabel.font = UIFont.boldSystemFont(ofSize: 16)
        symbolLabel.textColor = Colors.tint
    }
    
    
    func configureNameStackView() {
        nameStackView = UIStackView()
        contentView.addSubview(nameStackView)
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nameStackView.axis = .vertical
        nameStackView.alignment = .fill
        nameStackView.distribution = .fill
        
        nameStackView.addArrangedSubview(symbolLabel)
        nameStackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            nameStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            nameStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),

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
