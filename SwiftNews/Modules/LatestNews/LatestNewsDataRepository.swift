//
//  LatestNewsDataRepository.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

struct LatestNewsDataRepository: LatestNewsRepository, DataCacheable {
    private let filePath: URL = {
        FileManager.documentsDirectory.appending(path: "latest")
    }()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.coding)
        return decoder
    }()

    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.coding)
        return encoder
    }()

    /*func fetchArticles() -> [NewsArticle]? {
        guard let fileURL = Bundle.main.url(forResource: "LatestNews", withExtension: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let latestArticle = try decoder.decode(LatestArticles.self, from: data)

            save(articles: latestArticle.articles)

            return latestArticle.articles
        } catch {
            debugPrint(error)
            return nil
        }
    }*/

    func getCacheArticles() -> [NewsArticle]? {
        do {
            let data = try Data(contentsOf: filePath)
            let articles = try decoder.decode([NewsArticle].self, from: data)
            return articles
        } catch {
            debugPrint(error)
            return nil
        }
    }

//    func fetchArticles() -> [NewsArticle]? {
//        do {
//            let data = try Data(contentsOf: filePath)
//            let articles = try decoder.decode([NewsArticle].self, from: data)
//            return articles
//        } catch {
//            debugPrint(error)
//            return nil
//        }
//    }

    func save(articles: [NewsArticle]) {
        do {
            let data = try encoder.encode(articles)
            try data.write(to: filePath, options: [.atomic, .completeFileProtection])
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
