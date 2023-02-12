//
//  LatestNewsEndpoint.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

enum LatestNewsEndpoint {
    case getNews
}

extension LatestNewsEndpoint: Endpoint {
    var baseURL: String {
        return self.newsBaseURL
    }

    var path: String {
        return "v2/top-headlines"
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: HTTPHeaders {
        return defaultHeaders
    }

    var queryParams: Parameters? {
        return ["country": "in"]
    }
}
