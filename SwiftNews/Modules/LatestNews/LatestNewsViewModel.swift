//
//  LatestNewsViewModel.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import Foundation

@MainActor
final class LatestNewsViewModel: ObservableObject {
    enum ViewState {
        case latestNews, favourite
    }

    @Published var isLoading: Bool = false
    @Published var articles: [Article] = []
    @Published var viewState: ViewState = .latestNews {
        didSet {
            manageViewState()
        }
    }
    private var allArticles: [Article] = []
    private var favourites: [URL] = []

    private let newsDataManager: LatestNewsDataManager = LatestNewsDataManager()
    private var favouriteDataManager: FavouriteDataManager = FavouriteDataManager()

    func fetchData() {
        getFavourites()
        getCacheArticles()
        getNewLatestArticles()
    }

    func getCacheArticles() {
        if let cacheArticles = newsDataManager.getArticlesFromCache() {
            createNewsItemModel(for: cacheArticles)
        }
    }

    func getFavourites() {
        favourites = favouriteDataManager.fetchFavouriteNews()
    }

    func getNewLatestArticles() {
        Task {
            guard let newArticles = await newsDataManager.fetchNewArticles(), !newArticles.isEmpty else {
                return
            }
            allArticles.removeAll()
            createNewsItemModel(for: newArticles)
        }
    }

    private func createNewsItemModel(for articles: [Article]) {
        // Check for favourites
        for article in articles {
            var newArticleModel = NewsItemViewModel(article: article)

            if favourites.contains([article.url]) {
                newArticleModel.isFavourite = true
            }
            allArticles.append(newArticleModel)
        }
        self.articles = allArticles
    }

    func toggleFavourites() {
        switch viewState {
        case .latestNews:
            viewState = .favourite
        case .favourite:
            viewState = .latestNews
        }
    }

    func toogleFavourite(forAartileWith url: URL) {
        guard let index = allArticles.firstIndex(where: { $0.url == url }) else { return }
        if allArticles[index].isFavourite {
            favourites.removeAll(where: { $0 == url })
            favouriteDataManager.removeFavourite(with: url)
        } else {
            favourites.append(url)
            favouriteDataManager.addFavourite(with: url)
        }
        allArticles[index].isFavourite.toggle()
        manageViewState()
    }

    private func manageViewState() {
        switch viewState {
        case .latestNews:
            articles = allArticles

        case .favourite:
            articles = allArticles.filter({ $0.isFavourite })
        }
    }
}
