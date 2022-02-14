//
//  DataManager.swift
//  Currency Converter
//
//  Created by Александр on 13/02/2022.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    let currencies = [
        CurrencyInfo(image: "USD", name: "USD", currencyCode: "840"),
        CurrencyInfo(image: "RUB", name: "RUB", currencyCode: "643"),
        CurrencyInfo(image: "EUR", name: "EUR", currencyCode: "978"),
        CurrencyInfo(image: "BYN", name: "BYN", currencyCode: "933"),
    ]
}
