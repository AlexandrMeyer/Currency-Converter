//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

//final class NetworkManager {
//
//    static let shared = NetworkManager()
//
//    private init() {}
//
//    enum Link: String {
//        case currentExchangeRate = "https://api.currencyscoop.com/v1/latest"
//        case currenciesList = "https://api.currencyscoop.com/v1/currencies"
//        case currencyConverter = "https://api.currencyscoop.com/v1/convert"
//    }
//
//    var apiKey: String  {
//        "?api_key=5ccd5a7923e404eb0f42753f793a1160"
//    }
//
//    var url = "https://api.currencyscoop.com/v1/convert?api_key=5ccd5a7923e404eb0f42753f793a1160&from=USD&to=RUB&amount=10"
//    var url2 = "https://api.currencyscoop.com/v1/currencies?api_key=5ccd5a7923e404eb0f42753f793a1160&type=fiat"
//
//
//
//
//    func fetchCurrencyInfo(from: String, to: String, amount: String, completion: @escaping(Result<Currency?, NetworkError>) -> Void) {
//        NetworkService.shared.request(from: from, to: to, amount: amount) { data, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let jsonDecoder = JSONDecoder()
//                let imageInfo = try jsonDecoder.decode(Currency.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(imageInfo))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }
//    }
//
//
//    func fetchCurrencies(completion: @escaping(Result<Currencies?, NetworkError>) -> Void) {
//        guard let url = URL(string: url2) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let currenciesInfo = try JSONDecoder().decode(Currencies.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(currenciesInfo))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
//    }
//}



final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrencyInfo(from: String, to: String, amount: String? = nil, completion: @escaping(Result<Convert, NetworkError>) -> Void) {
        NetworkService.shared.request(from: from, to: to, amount: amount) { data, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let imageInfo = try jsonDecoder.decode(Convert.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(imageInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
}
