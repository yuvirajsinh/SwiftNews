//
//  LatestNewsRepository.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import Foundation

protocol DataCacheable {
    func getCacheArticles() -> [NewsArticle]?
    func save(articles: [NewsArticle])
}

protocol LatestNewsRepository {
    func fetchArticles() async -> [NewsArticle]?
//    func save(articles: [NewsArticle])
}

extension LatestNewsRepository {
    func fetchArticles() async -> [NewsArticle]? { return nil }
}

//extension LatestNewsRepository {
//    func save(articles: [NewsArticle]) {}
//}
