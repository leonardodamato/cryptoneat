//
//  BitcoinPriceViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 6/10/21.
//

import UIKit

class BitcoinPriceViewController: UIViewController {

    var viewModel = BitcoinPriceViewModel()
    
    var stackView: UIStackView!
    var btcTitleLabel: UILabel!
    var btcPriceLabel: UILabel!
    
    var btcPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBitcoinPrice {
            self.configureLabels()
            self.configureStackView()
        }
    }
    
    
    func configureLabels() {
        ///Title label
        ///
        btcTitleLabel = UILabel()
        
        btcTitleLabel.textColor = Colors.tint
        btcTitleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        btcTitleLabel.textAlignment = .center
        
        btcTitleLabel.text = "Bitcoin"
        
        
        ///Price label
        btcPriceLabel = UILabel()
        
        btcPriceLabel.textColor = Colors.tint
        btcPriceLabel.font = .systemFont(ofSize: 36, weight: .bold)
        btcPriceLabel.textAlignment = .center
        
        btcPriceLabel.text = btcPrice?.formatCurrency()
    }
    
    
    func configureStackView() {
        stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(btcTitleLabel)
        stackView.addArrangedSubview(btcPriceLabel)
    }
    
    
    func getBitcoinPrice(completion: @escaping ()->()) {
        viewModel.getBitcoinPrice { [weak self] (result) in
            switch result {
            case .success(let market):
                self?.btcPrice = market.currentPrice
            case .failure(let error):
                //TODO: Handle errors
                print(error.localizedDescription)
            }
            completion()
        }
    }
}
