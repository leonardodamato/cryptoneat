//
//  ISO8601DateFormatter+Ext.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}
