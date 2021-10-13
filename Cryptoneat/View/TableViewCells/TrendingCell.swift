//
//  TrendingCell.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 13/10/21.
//

import UIKit

class TrendingCell: UITableViewCell {

    var item: Item?
    
    var stackView: UIStackView!

    var positionNumberLabel: UILabel!
    var logoImageView: UIImageView!
    var coinSymbolLabel: UILabel!
    var coinNameLabel: UILabel!
    var coinNameAndSymbolStackView: UIStackView!
    
 
    func configure() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        guard item != nil else { return }
        
        configurePositionNumberLabel()
        configureLogoImageView()
        configureCoinSymbolLabel()
        configureCoinNameLabel()
        configureCoinNameAndSymbolStackView()
        configureStackView()
    }
    
    
    func configurePositionNumberLabel() {
        guard let item = item else { return }
        
        positionNumberLabel = UILabel()
        positionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        positionNumberLabel.textColor = Colors.secondary
        positionNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        let positionString = String(item.score + 1)
        
        positionNumberLabel.text = positionString
        
        NSLayoutConstraint.activate([
            positionNumberLabel.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func configureLogoImageView() {
        guard let item = item else { return }
        
        let viewModel = TrendingViewModel(coin: item)

        logoImageView = viewModel.image
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func configureCoinSymbolLabel() {
        guard let item = item else { return }
        
        let viewModel = TrendingViewModel(coin: item)

        coinSymbolLabel = UILabel()
        coinSymbolLabel.textColor = Colors.tint
        coinSymbolLabel.font = .systemFont(ofSize: 16, weight: .bold)
        coinSymbolLabel.text = viewModel.symbol

    }
    
    
    func configureCoinNameLabel() {
        guard let item = item else { return }

        let viewModel = TrendingViewModel(coin: item)
        
        coinNameLabel = UILabel()
        coinNameLabel.textColor = Colors.secondary
        coinNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        coinNameLabel.text = viewModel.name
    }
    
    
    func configureCoinNameAndSymbolStackView() {
        coinNameAndSymbolStackView = UIStackView()
        coinNameAndSymbolStackView.axis = .vertical
        coinNameAndSymbolStackView.distribution = .fill
        
        coinNameAndSymbolStackView.addArrangedSubview(coinSymbolLabel)
        coinNameAndSymbolStackView.addArrangedSubview(coinNameLabel)
    }
    
    
    func configureStackView() {
        stackView = UIStackView()
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        
        stackView.addArrangedSubview(positionNumberLabel)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(coinNameAndSymbolStackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
