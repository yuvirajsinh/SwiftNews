//
//  API.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

protocol Networking {
    func execute(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class API: Networking {
    var urlSession: URLSession

    init(session: URLSession = .shared) {
        urlSession = session
    }

    func execute(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        urlSession.dataTask(with: request, completionHandler: completion)
        .resume()
    }
}

final class APIManager {
    private let networking: Networking
    private let decoder: JSONDecoder

    init(networking: Networking = API(), decoder: JSONDecoder = JSONDecoder()) {
        self.networking = networking
        self.decoder = decoder
    }

    func execute<Value: Decodable>(_ request: Endpoint, completion: @escaping (Result<Value, Error>) -> Void) {
        networking.execute(urlRequest(for: request)) { responseData, response, error in
            if let data = responseData {
                do {
                    let response = try self.decoder.decode(Value.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error!))
            }
        }
    }

    private func urlRequest(for endpoint: Endpoint) -> URLRequest {
        let url = URL(endpoint)
        var result = URLRequest(url: url)
        result.httpMethod = endpoint.method.rawValue
        result.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        for header in endpoint.headers {
            result.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return result
    }

}


extension URL {
    func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }

    init(_ endpoint: Endpoint) {
        var queryItems: [URLQueryItem] = []
        if let params = endpoint.queryParams {
            queryItems = params.map { (key: String, value: Any) in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        let url = URL(string: endpoint.baseURL)!
            .appendingPathComponent(endpoint.path)
            .url(with: queryItems)

        self.init(string: url.absoluteString)!
    }
}
