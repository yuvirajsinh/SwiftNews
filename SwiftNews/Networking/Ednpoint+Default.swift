//
//  Ednpoint+Default.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

extension Endpoint {
    var defaultHeaders: HTTPHeaders {
        let headers = ["Accept": "application/json",
                       "X-Api-Key": "dfc0d70bd8b948ebab79751aa867be8a",
                       "Content-Type": "application/json"]

        return headers
    }

    var newsBaseURL: String {
        return "https://newsapi.org"
    }
}
