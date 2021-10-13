//
//  LoadingView.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 24/9/21.
//

import UIKit

class LoadingView: UIView {
      
    var loadingImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    
    func configureImage() {
        loadingImage = UIImageView()
        self.addSubview(loadingImage)
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        loadingImage = UIImageView(image: UIImage(systemName: "bolt.fill")!.withTintColor(Colors.tint))
        
        NSLayoutConstraint.activate([
            //loadingImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //loadingImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingImage.heightAnchor.constraint(equalToConstant: 60),
            loadingImage.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        loadingImage.rotate()
    }
}
