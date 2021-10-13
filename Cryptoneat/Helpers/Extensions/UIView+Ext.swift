//
//  UIView+Ext.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 16/9/21.
//

import UIKit

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    //MARK: - Animations
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    
    //MARK: - Loading View Handler
    func showLoadingView() {
        let loadingView = LoadingView()
        self.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
