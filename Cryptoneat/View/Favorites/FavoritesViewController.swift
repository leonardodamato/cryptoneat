//
//  FavoritesViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    lazy var viewModel = FavoritesViewModel()
    
    var favorites: [Market] = []
    
    var tableView: UITableView!
    
    var emptyStateView: EmptyStateView {
        let image = UIImage(systemName: "star.slash")!
        let text = "You do not have any favorite yet"
        return EmptyStateView(image: image, text: text)
        }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        ///The function getFavorites() shoul be called only if the user has any market as favorite
        ///because if you pass the "ids" parameter as an empty string, the API will fetch all the markets and ignore this parameter
        ///
//        guard viewModel.userHasFavorites else {
//            tableView.backgroundView = emptyStateView
//            return
//        }
        
        getFavorites {
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = Colors.bg
        self.navigationItem.title = "Favorites"
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.reloadData()
    }
    
    
    //MARK: - Actions
    func getFavorites(completion: @escaping () -> ()) {
        let service = MarketsService()
        
        service.getSomeMarkets(markets: viewModel.fetchFavorites()) { [weak self] (result) in
            switch result {
            case .success(let markets):
                self?.favorites = markets
            case .failure(let error):
                //TODO: - Handle error
                print(error.localizedDescription)
            }
            
            completion()
        }
    }
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count > 0 ? favorites.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell") as! MarketCell
        cell.configure(with: favorites[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMarket =  favorites[indexPath.row]
        
        let vc = MarketViewController(market: selectedMarket)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
