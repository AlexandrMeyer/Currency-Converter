//
//  ReuseIdentifier.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import Foundation

enum ReuseIdentifier: String {
    case cell = "cell"
}

let rateFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    return formatter
}()
