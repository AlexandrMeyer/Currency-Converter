//
//  Currency.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import Foundation

//struct Responce: Decodable {
//    let responce: Info
//}
//
//struct Info: Decodable {
//    let date: String?
//    let from: String?
//    let to: String?
//    let amount: Float?
//    let value: Double?
//}
//
//struct Currencies: Decodable {
//    let response: FiatResponce
//}
//
//struct FiatResponce: Decodable {
//    let fiats: Currency
//}
//
//struct Currency: Decodable {
//    let USD: CurrencyCode
//    let RUB: CurrencyCode
//    let EUR: CurrencyCode
//    let BYN: CurrencyCode
//}
//
//struct CurrencyCode: Decodable {
//    let currencyCode: String
//    let currencyName: String
//
//    enum CodingKeys: String, CodingKey {
//        case currencyCode = "currency_code"
//        case currencyName = "currency_name"
//    }
//}

struct CurrencyInfo {
    let image: String
    let name: String
    let currencyCode: String
}

struct Convert: Decodable {
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

struct Currencies: Decodable {
    let USD: CurrencyCode?
    let RUB: CurrencyCode?
    let EUR: CurrencyCode?
    let BYN: CurrencyCode?
}

struct CurrencyCode: Decodable {
    let description: String?
    let code: String?
}
