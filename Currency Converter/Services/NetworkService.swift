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
    
    func request(from: String, to: String, amount: String?, completion: @escaping(Data?, Error?) -> Void) {
        let parameters = prepareParameters(from: from, to: to, amount: amount)
        guard let url = url(parameters: parameters) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParameters(from: String?, to: String?, amount: String?) -> [String: String] {
        var parameters: [String: String] = [:]
        parameters["from"] = from
        parameters["to"] = to
        parameters["amount"] = amount
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.exchangerate.host"
        components.path = "/convert"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
