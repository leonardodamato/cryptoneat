//
//  Date+Ext.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import Foundation

extension Date {
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}
