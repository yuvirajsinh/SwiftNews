//
//  LatestArticles.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 09/02/23.
//

import Foundation

struct LatestArticles: Codable {
    let status: String
    let totalResults: Int
    var articles: [NewsArticle]
}
