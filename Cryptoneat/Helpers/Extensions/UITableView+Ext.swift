//
//  UITableView+Ext.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 8/10/21.
//

import UIKit

extension UITableView {
    func heightToContent() {
        
        self.isScrollEnabled = false
        self.bounces = false 
//        var frame = self.frame
//        frame.size.height = self.contentSize.height
//        self.frame = frame
//
//        self.layoutIfNeeded()
//        self.heightAnchor.constraint(equalToConstant: self.contentSize.height).isActive = true
    }
}
