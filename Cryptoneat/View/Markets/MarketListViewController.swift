//
//  MarketsViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import UIKit

class MarketListViewController: UIViewController {

    var service = MarketsService()
    var markets: [Market] = []
    var filteredMarkets: [Market] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var searchController: UISearchController!
    var tableViewHeader: UIView!
    var tableView: UITableView!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        getMarkets() 
    }
    
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = Colors.bg
        self.navigationItem.title = "Markets"
        
        configureSearchController()
        configureTableViewHeader()
        configureTableView()
    }
    
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Markets"
        searchController.searchBar.barStyle = .black

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    func configureTableViewHeader() {
        tableViewHeader = UIView()
        view.addSubview(tableViewHeader)
        tableViewHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableViewHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        tableViewHeader.addSubview(priceLabel)
        
        priceLabel.text = "Price (USD)"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textColor = Colors.secondary
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: tableViewHeader.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: tableViewHeader.trailingAnchor, constant: -105),
            priceLabel.bottomAnchor.constraint(equalTo: tableViewHeader.bottomAnchor)
        ])
        
        let pctLabel = UILabel()
        pctLabel.translatesAutoresizingMaskIntoConstraints = false
        tableViewHeader.addSubview(pctLabel)
        
        pctLabel.text = "24h Change"
        pctLabel.font = UIFont.boldSystemFont(ofSize: 12)
        pctLabel.textColor = Colors.secondary
        
        NSLayoutConstraint.activate([
            pctLabel.topAnchor.constraint(equalTo: tableViewHeader.topAnchor),
            pctLabel.trailingAnchor.constraint(equalTo: tableViewHeader.trailingAnchor, constant: -10),
            pctLabel.bottomAnchor.constraint(equalTo: tableViewHeader.bottomAnchor)
        ])
    }
    
    func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(MarketCell.self, forCellReuseIdentifier: "MarketCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableViewHeader.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    //MARK: - Actions
    func filterMarketsForSearchText(_ searchText: String) {
        
        filteredMarkets = markets.filter { (market: Market) -> Bool in  
            let name = market.name.lowercased().contains(searchText.lowercased())
            let symbol = market.symbol.lowercased().contains(searchText.lowercased())

            return name || symbol
        }
      
      tableView.reloadData()
    }
    
    func getMarkets() {
        service.getMarkets(page: 1, perPage: 250) { result in
            switch result {
            case .success(let markets):
                self.markets = markets
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//MARK: - TableView DataSource and Delegate
extension MarketListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredMarkets.count : markets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketCell
        
        if isFiltering {
            cell.configure(with: filteredMarkets[indexPath.row])
        } else {
            cell.configure(with: markets[indexPath.row])
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMarket = isFiltering ? filteredMarkets[indexPath.row] : markets[indexPath.row]
        
        let vc = MarketViewController(market: selectedMarket)
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - Search Results Updating
extension MarketListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterMarketsForSearchText(searchBar.text!)
    }
}
