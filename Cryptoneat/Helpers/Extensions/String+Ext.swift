//
//  String+Ext.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import Foundation

extension String {    
    
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
}
