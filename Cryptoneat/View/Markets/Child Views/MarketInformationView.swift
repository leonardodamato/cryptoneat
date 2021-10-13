//
//  MarketInformationView.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 21/9/21.
//

import UIKit

class MarketInformationView: UIView {
    
    var market: Market
    
    var titleLabel: UILabel!
    
    init(market: Market) {
        self.market = market
        super.init(frame: .zero)
        
        configureTitleLabel()
        createMainStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureTitleLabel() {
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Market Information"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = Colors.secondary
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func createMainStackView() {
        let viewModel = MarketViewModel(market: market)
        
        
        ///Configure main stackView
        ///
        let mainStackView = UIStackView()
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        
        mainStackView.spacing = 12
        
        
        ///Configure secondary stackViews
        ///
        let rankTitle = "Market Cap Rank"
        let rankValue = viewModel.formatNumberWithMaximumTwoDecimalPlaces(for: (market.marketCapRank ?? 0) as NSNumber)
        let rankStackView = createHorizontalStackView(rankTitle, value: rankValue)
        
        let marketCapTitle = "Market Cap"
        let marketCapValue = viewModel.formatNumberWithMaximumTwoDecimalPlaces(for: (market.marketCap ?? 0) as NSNumber)
        let marketCapStackView = createHorizontalStackView(marketCapTitle, value: marketCapValue)
        
        let totalVolumeTitle = "Total Volume"
        let totalVolumeValue = viewModel.formatNumberWithMaximumTwoDecimalPlaces(for: (market.totalVolume ?? 0) as NSNumber)
        let totalVolumeStackView = createHorizontalStackView(totalVolumeTitle, value: totalVolumeValue)
        
        let circulatingSupplyTitle = "Circulating Supply"
        let circulatingSupplyValue = viewModel.formatNumberWithMaximumTwoDecimalPlaces(for: (market.circulatingSupply ?? 0) as NSNumber)
        let circulatingSupplyStackView = createHorizontalStackView(circulatingSupplyTitle, value: circulatingSupplyValue)
        
        let totalSupplyTitle = "Total Supply"
        let totalSupplyValue = viewModel.formatNumberWithMaximumTwoDecimalPlaces(for: (market.totalSupply ?? 0) as NSNumber)
        let totalSupplyStackView = createHorizontalStackView(totalSupplyTitle, value: totalSupplyValue)
        
        
        ///Add arranged subviews
        ///
        mainStackView.addArrangedSubview(rankStackView)
        mainStackView.addArrangedSubview(marketCapStackView)
        mainStackView.addArrangedSubview(totalVolumeStackView)
        mainStackView.addArrangedSubview(circulatingSupplyStackView)
        mainStackView.addArrangedSubview(totalSupplyStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    
    func createHorizontalStackView(_ title: String, value: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = Colors.secondary
        titleLabel.textAlignment = .left
        
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .boldSystemFont(ofSize: 16)
        valueLabel.textColor = Colors.secondary
        valueLabel.textAlignment = .right
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        return stackView
    }
}
