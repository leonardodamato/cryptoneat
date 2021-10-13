//
//  EmptyStateView.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 27/9/21.
//

import UIKit

class EmptyStateView: UIView {
    
    var stackView: UIStackView!
    var imageView: UIImageView!
    var textLabel: UILabel!
    
    var image: UIImage!
    var text: String!

    
    init(image: UIImage, text: String) {
        super.init(frame: .zero)
        self.image = image
        self.text = text
        
        configureContent()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///This function will configure the imageView and the TextLabel to be added to the stackView
    ///
    func configureContent() {
        
        ///ImageView
        ///
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageWithTint = image.withTintColor(Colors.secondary, renderingMode: .alwaysOriginal)
        imageView.image = imageWithTint
        imageView.contentMode = .scaleAspectFit
        
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),

        ])
        
        
        ///TextLabel
        ///
        textLabel = UILabel()
        textLabel.text = text
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = Colors.secondary
        textLabel.textAlignment = .center
    }
    
    
    func configureStackView() {
        stackView = UIStackView()
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
}
