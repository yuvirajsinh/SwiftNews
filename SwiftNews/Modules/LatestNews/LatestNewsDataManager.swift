//
//  LatestNewsDataManager.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

struct LatestNewsDataManager {
    private let dataRepository: LatestNewsRepository & DataCacheable = LatestNewsDataRepository()
    private let networkRepository: LatestNewsRepository = LatestNewsNetworkRepository()

    func getArticlesFromCache() -> [NewsArticle]? {
        dataRepository.getCacheArticles()
    }

    func fetchNewArticles() async -> [NewsArticle]? {
        guard let articles = await networkRepository.fetchArticles() else {
            return nil
        }
        save(newArticles: articles)
        return articles
    }

    func save(newArticles: [NewsArticle]) {
        dataRepository.save(articles: newArticles)
    }
}
