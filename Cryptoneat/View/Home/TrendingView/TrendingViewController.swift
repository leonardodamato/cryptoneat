//
//  TrendingViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 6/10/21.
//

import UIKit

class TrendingViewController: UIViewController {

    var viewModel: TrendingViewModel!
    var trending: Trending?

    var titleLabel: UILabel!
    var sourceLabel: UILabel!
    var tableView: ContentSizedTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        getTrendingCoins {
            self.configureTitleLabel()
            self.configureTableView()
            self.configureSourceLabel()
        }
    }
    
    
    func configureUI() {
        view.backgroundColor = Colors.bgWithAlpha
        view.layer.cornerRadius = 15
    }
    
    
    func configureTitleLabel() {
        viewModel = TrendingViewModel()
        
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textAlignment = .center
        titleLabel.text = viewModel.title
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = Colors.secondary
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    func configureSourceLabel() {
        viewModel = TrendingViewModel()
        
        sourceLabel = UILabel()
        view.addSubview(sourceLabel)
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        sourceLabel.textAlignment = .center
        sourceLabel.text = viewModel.source
        sourceLabel.font = .systemFont(ofSize: 12)
        sourceLabel.textColor = Colors.secondary
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            sourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    
    func configureTableView() {
        tableView = ContentSizedTableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TrendingCell.self, forCellReuseIdentifier: "TrendingCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    


    
    
    func getTrendingCoins(completion: @escaping ()->()) {
        let viewModel = TrendingViewModel()
        
        viewModel.getTrendingCoins { [weak self] (result) in
            switch result {
            case .success(let trending):
                self?.trending = trending
            case .failure(let error):
                //TODO: Handle error
                print(error.localizedDescription)
            }
            completion()
        }
    }
}


extension TrendingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let trending = trending else { return 0 }
        return trending.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trending = trending else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        cell.item = trending.coins[indexPath.row].item
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trending = trending else { return }
        
        let trendingCoin = trending.coins[indexPath.row].item
        
        let service = MarketsService()
        service.getSomeMarkets(markets: [trendingCoin.id]) { (result) in
            switch result {
            case .success(let markets):
                let vc = MarketViewController(market: markets[0])
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
