//
//  LatestNewsViewModelTests.swift
//  SwiftNewsTests
//
//  Created by Yuvrajsinh Jadeja on 13/02/23.
//

import XCTest
@testable import SwiftNews

@MainActor
final class LatestNewsViewModelTests: XCTestCase {
    private let viewModel: LatestNewsViewModel = LatestNewsViewModel()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getCacheArticles_shouldBeEmpty() {
        clearCacheArticles()
        viewModel.getCacheArticles()
        XCTAssertTrue(viewModel.articles.isEmpty, "Cached news articles should be empty")
    }

    func test_saveCacheArticles() {
        cacheArticles()
        viewModel.getCacheArticles()
        XCTAssertTrue(viewModel.articles.isEmpty == false, "Cached articles should not be empty")
    }

    func test_make_favourite() {
        cacheArticles()
        clearFavourites()

        viewModel.getCacheArticles()
        guard let url = viewModel.articles.first?.url else {
            XCTFail("Articles should not be empty")
            return
        }
        viewModel.toogleFavourite(forAartileWith: url)
        XCTAssertTrue(viewModel.articles.first?.isFavourite == true, "News article should be Favourite")
    }

    func test_remove_favourite() {
        cacheArticles()
        clearFavourites()

        viewModel.getCacheArticles()
        guard let url = viewModel.articles.first?.url else {
            XCTFail("Articles should not be empty")
            return
        }
        viewModel.toogleFavourite(forAartileWith: url)
        XCTAssertTrue(viewModel.articles.first?.isFavourite == true, "News article should be Favourite")
        viewModel.toogleFavourite(forAartileWith: url)
        XCTAssertTrue(viewModel.articles.first?.isFavourite == false, "News article should not be Favourite")
    }
}

extension XCTestCase {
    func clearCacheArticles() {
        let dataManager = LatestNewsDataManager()
        dataManager.save(newArticles: [])
    }

    func getMockArticles() -> [NewsArticle]? {
        guard let fileURL = Bundle.main.url(forResource: "LatestNews", withExtension: "json") else {
            return nil
        }

        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.coding)
            return decoder
        }()

        do {
            let data = try Data(contentsOf: fileURL)
            let latestArticle = try decoder.decode(LatestArticles.self, from: data)
            return latestArticle.articles
        } catch {
            return nil
        }
    }

    func cacheArticles() {
//        guard let fileURL = Bundle.main.url(forResource: "LatestNews", withExtension: "json") else {
//            return
//        }
//
//        let decoder: JSONDecoder = {
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .formatted(DateFormatter.coding)
//            return decoder
//        }()
//
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let latestArticle = try decoder.decode(LatestArticles.self, from: data)
//
//            let dataManager = LatestNewsDataManager()
//            dataManager.save(newArticles: latestArticle.articles)
//        } catch {
//            return
//        }

        guard let articles = getMockArticles() else { return }

        let dataManager = LatestNewsDataManager()
        dataManager.save(newArticles: articles)
    }

    func clearFavourites() {
        var dataManager = FavouriteDataManager()
        dataManager.clear()
    }
}
