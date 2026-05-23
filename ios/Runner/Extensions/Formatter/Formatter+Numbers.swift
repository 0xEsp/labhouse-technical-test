//
//  Formatter+Numbers.swift
//  Runner
//
//  Created by Manu Espeso on 24/9/25.
//

import Foundation

extension Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        // formatter.minimumFractionDigits = 2 // Comment this line for remove 2 decimals when they're 0
        formatter.maximumFractionDigits = 2
        // formatter.decimalSeparator = "," // Force to use spanish decimal separator, remove for auto
        // formatter.groupingSeparator = "." // Force to use spanish decimal grouping, remove for auto
        
        return formatter
    }()
    
    static let withCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
}

extension Numeric {
    // 1234.56 -> "1.234,56", 1234.56 -> "1,234.56"
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
    
    var formattedWithCurrency: String { Formatter.withCurrency.string(for: self) ?? "" }
}

extension String {
    // ".", ",", etc...
    var formmatedSeparator: String { Formatter.withSeparator.groupingSeparator }
    
    // "1.234,56" -> 1234.56, "1,234.56" -> 1234.56
    var formmatedSeparatorToDouble: Double? { Formatter.withSeparator.number(from: self) as? Double }
}
