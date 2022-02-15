//
//  CurrencyConvert.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import Foundation

struct CurrencyConvert: Decodable {
    let query: Query?
    let info: Rate?
    let date: String?
    let result: Double?
}

struct Query: Decodable {
    let from: String?
    let to: String?
    let amount: Float?
}

struct Rate: Decodable {
    let rate: Double?
}

struct CurrencyInfo {
    let image: String
    let name: String
    let currencyCode: String
}
