//
//  LatestNewsNetworkRepository.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation
import Combine

struct LatestNewsNetworkRepository: LatestNewsRepository {
    private let apiManager: APIManager
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.coding)
        return decoder
    }()

    init() {
        apiManager = APIManager(decoder: decoder)
    }

    func fetchArticles() async -> [NewsArticle]? {
        return await withCheckedContinuation { continuation in
            apiManager.execute(LatestNewsEndpoint.getNews) { (result: Result<LatestArticles, Error>) in
                switch result {
                case .success(let latestArticles):
                    continuation.resume(returning: latestArticles.articles)
                case .failure:
                    continuation.resume(returning: nil)
                }
            }
        }

        /*apiManager.execute(LatestNewsEndpoint.getNews) { (result: Result<LatestArticles, Error>) in
            switch result {
            case .success(let latestArticles):
                print(latestArticles)
            case .failure(let error):
                print(error)
            }
        }*/


        /*guard let fileURL = Bundle.main.url(forResource: "LatestNews", withExtension: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let latestArticle = try decoder.decode(LatestArticles.self, from: data)

            return latestArticle.articles
        } catch {
            debugPrint(error)
            return nil
        }*/
    }
}
