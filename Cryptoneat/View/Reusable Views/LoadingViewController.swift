//
//  LoadingViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 24/9/21.
//

import UIKit

class LoadingViewController: UIViewController {

    let loadingImage: UIImageView = UIImageView(image: UIImage(systemName: "bolt.fill")!.withTintColor(Colors.tint))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureImage()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    
    func configureImage() {
        view.addSubview(loadingImage)
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loadingImage.heightAnchor.constraint(equalToConstant: 60),
            loadingImage.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        loadingImage.rotate()
    }
}
