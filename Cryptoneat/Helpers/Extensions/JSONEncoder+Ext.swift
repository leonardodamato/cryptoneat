//
//  JSONEncoder.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import Foundation

extension JSONEncoder.DateEncodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}
