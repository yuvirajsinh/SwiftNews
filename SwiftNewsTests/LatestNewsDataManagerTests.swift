//
//  LatestNewsDataManagerTests.swift
//  SwiftNewsTests
//
//  Created by Yuvrajsinh Jadeja on 13/02/23.
//

import XCTest
import Combine
@testable import SwiftNews

final class LatestNewsDataManagerTests: XCTestCase {
    private let dataManager = LatestNewsDataManager()

    func test_save_cache_data() {
        cacheArticles()
        guard let articles = getMockArticles() else {
            XCTFail("Unable to get mock data")
            return
        }
        dataManager.save(newArticles: articles)
        guard let cached = dataManager.getArticlesFromCache() else {
            XCTFail("Cached Articles should be there")
            return
        }
        XCTAssertEqual(articles.count, cached.count, "Cached articles should be same as saved")
    }

    func test_fetch_new_articles() {
        let expectation = expectation(description: "Should fetch latest news articles")
        Task {
            let newArticles = await dataManager.fetchNewArticles()
            if let articles = newArticles, !articles.isEmpty {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
