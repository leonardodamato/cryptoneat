//
//  HomeViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 28/9/21.
//

import UIKit

class HomeViewController: UIViewController {

    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var bitcoinViewController: BitcoinPriceViewController!
    var trendingViewController: TrendingViewController!
    var gainersAndLosersViewController: GainersAndLosersViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        configureScrollView()
        
        configureBitcoinPriceViewController()
        configureGainersAndLosersViewController()
        configureTrendingViewController()
    }
    
    
    func configureUI() {
        navigationItem.title = "Cryptoneat"
        view.backgroundColor = Colors.bg
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
    
    
    func configureBitcoinPriceViewController() {
        bitcoinViewController = BitcoinPriceViewController()
        
        addChild(bitcoinViewController)
        contentView.addSubview(bitcoinViewController.view)
        bitcoinViewController.didMove(toParent: self)
        
        bitcoinViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bitcoinViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            bitcoinViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bitcoinViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    
    func configureGainersAndLosersViewController() {
        gainersAndLosersViewController = GainersAndLosersViewController()
        
        addChild(gainersAndLosersViewController)
        contentView.addSubview(gainersAndLosersViewController.view)
        gainersAndLosersViewController.didMove(toParent: self)
        
        gainersAndLosersViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gainersAndLosersViewController.view.topAnchor.constraint(equalTo: bitcoinViewController.view.bottomAnchor, constant: 40),
            gainersAndLosersViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            gainersAndLosersViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    
    func configureTrendingViewController() {
        trendingViewController = TrendingViewController()
        
        addChild(trendingViewController)
        contentView.addSubview(trendingViewController.view)
        trendingViewController.didMove(toParent: self)
        
        trendingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trendingViewController.view.topAnchor.constraint(equalTo: gainersAndLosersViewController.view.bottomAnchor, constant: 20),
            trendingViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            trendingViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            trendingViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}


//MARK: - Scroll View Delegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
