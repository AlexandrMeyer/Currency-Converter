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

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrencyInfo(from: String, to: String, amount: String? = nil, completion: @escaping(Result<CurrencyConvert, NetworkError>) -> Void) {
        NetworkService.shared.request(from: from, to: to, amount: amount) { data, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let imageInfo = try jsonDecoder.decode(CurrencyConvert.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(imageInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
}
