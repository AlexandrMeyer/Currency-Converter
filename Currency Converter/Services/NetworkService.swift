//
//  NetworkService.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import Foundation

final class NetworkService {
    
    static var shared = NetworkService()
    
    private init() {}
    
    func request(from: String, to: String, amount: String, completion: @escaping(Data?, Error?) -> Void) {
        let parameters = prepareParameters(from: from, to: to, amount: amount)
        guard let url = url(parameters: parameters) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParameters(from: String?, to: String?, amount: String?) -> [String: String] {
        var parameters: [String: String] = [:]
        parameters["from"] = "USD"
        parameters["to"] = "RUB"
        parameters["amount"] = String(10)
        return parameters
    }
    
    private func prepareParameters() -> [String: String] {
        var parameters: [String: String] = [:]
        parameters["type"] = "fiat"
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.currencyscoop.com"
        components.path = "/v1/latest"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
//        var urlComponents = URLComponents(string: "https://api.currencyscoop.com/v1/latest")!
//        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
        return components.url
    }
    
    private func prepareHeaders() -> [String: String]? {
        var headers: [String: String] = [:]
        headers["Authorization"] = "Client-ID 5ccd5a7923e404eb0f42753f793a1160"
        return headers
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
