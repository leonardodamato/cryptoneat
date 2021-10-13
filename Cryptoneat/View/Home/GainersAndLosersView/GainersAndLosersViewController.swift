//
//  GainersAndLosersViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 7/10/21.
//

import UIKit

class GainersAndLosersViewController: UIViewController {

    var markets: [Market]?
    
    var viewModel: GainersAndLosersViewModel!
    
    var segmentedControl: UISegmentedControl!
    var tableView: ContentSizedTableView!
    
    var gainers: [Market]?
    var losers: [Market]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        
        getMarkets {
            guard let markets = self.markets else { return }
            self.viewModel = GainersAndLosersViewModel(markets: markets)

            self.gainers = self.viewModel.gainers
            self.losers = self.viewModel.losers
            
            self.configureSegmentedControl()
            self.configureTableView()

        }
    }
    
    
    func configureUI() {
        view.backgroundColor = Colors.bgWithAlpha
        view.layer.cornerRadius = 15
    }
    
    
    func configureSegmentedControl() {
        guard let markets = markets else { return }
        viewModel = GainersAndLosersViewModel(markets: markets)
        
        segmentedControl = UISegmentedControl(items: viewModel.segmentedControlItems)
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlIndexDidChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentTintColor = Colors.tint
        segmentedControl.layer.backgroundColor = Colors.bg.cgColor
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.secondary], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.bg], for: .selected)
        
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

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
        
        tableView.register(GainersLosersCell.self, forCellReuseIdentifier: "GainersLosersCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    
    //MARK: - Actions
    func getMarkets(completion: @escaping () -> ()) {
        let service = MarketsService()

        service.getMarkets(page: 1, perPage: 250) { [weak self] (result) in
            switch result {
            case .success(let markets):
                self?.markets = markets
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completion()
        }
    }
    
    
    @objc func segmentedControlIndexDidChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}


//MARK: - TableView DataSource and Delegate
extension GainersAndLosersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let markets = markets else { return UITableViewCell() }
        
        viewModel = GainersAndLosersViewModel(markets: markets)
        
        let selectedArray = segmentedControl.selectedSegmentIndex == 0 ? viewModel.gainers : viewModel.losers
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GainersLosersCell") as! GainersLosersCell
        
        cell.configure(with: selectedArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let markets = markets else { return }
        
        viewModel = GainersAndLosersViewModel(markets: markets)
        let selectedArray = segmentedControl.selectedSegmentIndex == 0 ? viewModel.gainers : viewModel.losers

        let market = selectedArray[indexPath.row]
        
        let vc = MarketViewController(market: market)
        navigationController?.pushViewController(vc, animated: true)
    }
}
