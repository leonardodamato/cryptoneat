//
//  TickerViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 16/9/21.
//

import UIKit

class MarketViewController: UIViewController {

    var market: Market
    var chartPrices: [MarketChart] = []
        
    var scrollView: UIScrollView!
    var contentView: UIView!
    var chartViewController: MarketChartViewController!
    var pricePanelView: UIView!
    var chartView: UIView!
    var segmentedControl: UISegmentedControl!
    var allTimeView: AllTimeView!
    var marketInformationView: MarketInformationView!
    
    
    //MARK: - Designated Initializers
    init(market: Market) {
        self.market = market
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configurePricePanelView()
        configureChartView()
        configureSegmentedControl()
        
        getMarketChart(days: "1") {
            self.configureChartViewController()
            self.configureAllTimeView()
            self.configureMarketInformationView()
        }
    }
    
    
    //MARK: - UI Configuration
    func configureUI() {
        view.backgroundColor = Colors.bg
        navigationItem.title = "\(market.symbol.uppercased()) (\(market.name))"
        configureScrollView()
    }
    
    
    func configureScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
    
    ///This function configures the top panel of the view, where you can see the current price and 24h variation of the select market
    ///
    func configurePricePanelView() {
        let viewModel = MarketViewModel(market: market)
        
        pricePanelView = UIView()
        contentView.addSubview(pricePanelView)
        pricePanelView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pricePanelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pricePanelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pricePanelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        let priceLabel = UILabel()
        pricePanelView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.text = viewModel.currentPrice
        priceLabel.font = UIFont.boldSystemFont(ofSize: 28)
        priceLabel.textColor = Colors.tint
        priceLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: pricePanelView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: pricePanelView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: pricePanelView.trailingAnchor)
        ])
        
        let change24hLabel = UILabel()
        pricePanelView.addSubview(change24hLabel)
        change24hLabel.translatesAutoresizingMaskIntoConstraints = false
        
        change24hLabel.text = viewModel.priceChangePercentage24h
        change24hLabel.font = UIFont.systemFont(ofSize: 14)
        change24hLabel.textColor = viewModel.priceChangePercentage24hColor
        change24hLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            change24hLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            change24hLabel.leadingAnchor.constraint(equalTo: pricePanelView.leadingAnchor),
            change24hLabel.trailingAnchor.constraint(equalTo: pricePanelView.trailingAnchor),
            change24hLabel.bottomAnchor.constraint(equalTo: pricePanelView.bottomAnchor)
        ])
    }
    
    
    ///Configure the view where the chart is shown
    ///
    func configureChartView() {
        chartView = UIView()
        contentView.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.backgroundColor = Colors.bgWithAlpha
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: pricePanelView.bottomAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 400)

        ])
    }
    
    
    ///Configure the segmented control in order to change the amount
    ///
    func configureSegmentedControl() {
        let viewModel = MarketViewModel(market: market)
        let items = viewModel.intervalArray
        
        segmentedControl = UISegmentedControl(items: items)
        contentView.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlIndexDidChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentTintColor = Colors.tint
        segmentedControl.layer.backgroundColor = Colors.bg.cgColor
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.secondary], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.bg], for: .selected)

        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
    }
    
    func configureChartViewController() {
        chartViewController = MarketChartViewController(data: chartPrices)
        
        addChild(chartViewController)
        contentView.addSubview(chartViewController.view)
        chartViewController.didMove(toParent: self)
        
        chartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chartViewController.view.topAnchor.constraint(equalTo: chartView.topAnchor),
            chartViewController.view.leadingAnchor.constraint(equalTo: chartView.leadingAnchor),
            chartViewController.view.trailingAnchor.constraint(equalTo: chartView.trailingAnchor),
            chartViewController.view.bottomAnchor.constraint(equalTo: chartView.bottomAnchor)

        ])
    }
    
    
    func configureAllTimeView() {
        allTimeView = AllTimeView(market: market)
        contentView.addSubview(allTimeView)
        allTimeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allTimeView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 15),
            allTimeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            allTimeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    
    func configureMarketInformationView() {
        marketInformationView = MarketInformationView(market: market)
        contentView.addSubview(marketInformationView)
        marketInformationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            marketInformationView.topAnchor.constraint(equalTo: allTimeView.bottomAnchor, constant: 15),
            marketInformationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            marketInformationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            marketInformationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK: - Actions
    func getMarketChart(days: String, completion: @escaping () -> ()) {
        let service = MarketsService()
        
        service.getMarketChart(for: market, days: days) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let chart):
                self.chartPrices = chart
            case .failure(let error):
                print(error)
            }
            
            completion()
        }
    }
    
    
    @objc func segmentedControlIndexDidChange(_ sender: UISegmentedControl) {
        var days: String = ""
        
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                days = "1"
            case 1:
                days = "7"
            case 2:
                days = "15"
            case 3:
                days = "30"
            case 4:
                days = "90"
            case 5:
                days = "180"
            case 6:
                days = "365"
            case 7:
                days = "max"
            default:
                days = "1"
        }
        
        getMarketChart(days: days) {
            self.removeChartViewController()
            self.configureChartViewController()
        }
    }
    
    
    func removeChartViewController() {
        for controllers in self.children
        {
            controllers.willMove(toParent: nil)
            controllers.view.removeFromSuperview()
            controllers.removeFromParent()
        }
    }
}


//MARK: - Scroll View Delegate
extension MarketViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
