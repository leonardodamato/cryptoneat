//
//  HighLowView.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 21/9/21.
//

import UIKit

class AllTimeView: UIView {

    enum `Type` {
        case high
        case low
    }
    
    var market: Market
    
    var allTimeLabel: UILabel!


    
    init(market: Market) {
        self.market = market
        super.init(frame: .zero)
        
        configureAllTimeLabel()
        configurePanels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureAllTimeLabel() {
        ///All Time Text: "All Time"
        ///
        allTimeLabel = UILabel()
        allTimeLabel.textColor = Colors.secondary
        allTimeLabel.font = .boldSystemFont(ofSize: 16)
        allTimeLabel.text = "All Time"
        allTimeLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            allTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            allTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            allTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    func configurePanels() {
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        let highView = configurePanel(for: .high)
        let lowView = configurePanel(for: .low)
        
        stackView.addArrangedSubview(highView)
        stackView.addArrangedSubview(lowView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: allTimeLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    
    func configurePanel(for type: Type) -> UIView {
        let viewModel = MarketViewModel(market: market)
        
        
        ///Configure View
        ///
        let view = UIView()
        self.addSubview(view)
        
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        view.layer.borderColor = Colors.secondary.cgColor
        
        
        ///Main StackView
        ///
        let mainStackView = UIStackView()
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.axis = .vertical
        
        
        ///Text StackView:  "High 􀄤" or "Low 􀄥"
        ///
        let textStack = UIStackView()
        
        textStack.axis = .horizontal
        
        let textLabel = UILabel()
        textLabel.text = type == .high ? "High" : "Low"
        textLabel.textColor = Colors.secondary
        textLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        let arrowLabel = UILabel()
        arrowLabel.text = type == .high ? "􀄤" : "􀄥"
        arrowLabel.textColor = type == .high ? .systemGreen : .systemRed
        arrowLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        textStack.addArrangedSubview(textLabel)
        textStack.addArrangedSubview(arrowLabel)
        
        
        ///Price Text: "$2.56"
        ///
        let priceLabel = UILabel()
        priceLabel.textColor = Colors.tint
        priceLabel.font = .boldSystemFont(ofSize: 22)
        let price = (type == .high ? market.ath : market.atl) ?? 0
        priceLabel.text = viewModel.formatCurrency(for: price)
        
        
        ///Date Text: "20 january 2020"
        ///
        let dateLabel = UILabel()
        dateLabel.textColor = Colors.secondary
        dateLabel.font = .systemFont(ofSize: 12)
        let date = (type == .high ? market.athDate : market.atlDate) ?? ""
        priceLabel.text = viewModel.formatLongDate(for: date)
        
        
        ///Add Arranged Subviews
        ///
        mainStackView.addArrangedSubview(textStack)
        mainStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(dateLabel)
        
//
//        NSLayoutConstraint.activate([
//            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
//        ])
        
        return view
    }

}
