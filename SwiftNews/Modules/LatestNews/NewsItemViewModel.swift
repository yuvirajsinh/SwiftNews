//
//  NewsItemViewModel.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import Foundation

struct NewsItemViewModel: Article {
    // var id: UUID
    var title: String
    var description: String?
    var author: String?
    var url: URL
    var urlToImage: URL?
    var publishedAt: Date
    var isFavourite: Bool = false

//    init(title: String, description: String, author: String, url: URL, urlToImage: URL, publishedAt: Date, isFavourite: Bool) {
//        self.title = title
//        self.description = description
//        self.author = author
//        self.url = url
//        self.urlToImage = urlToImage
//        self.publishedAt = publishedAt
//        self.isFavourite = isFavourite
//    }
}

extension NewsItemViewModel {
    init(article: any Article) {
        self.title = article.title
        self.description = article.description
        self.author = article.author
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.publishedAt = article.publishedAt
        self.isFavourite = article.isFavourite
    }
}

/*
class NewsItemViewModel: Article {
    // var id: UUID
    var title: String
    var description: String
    var author: String
    var url: URL
    var urlToImage: URL
    var publishedAt: Date
    var isFavourite: Bool = false

    init(title: String, description: String, author: String, url: URL, urlToImage: URL, publishedAt: Date, isFavourite: Bool) {
        self.title = title
        self.description = description
        self.author = author
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.isFavourite = isFavourite
    }
}

extension NewsItemViewModel {
    convenience init(article: any Article) {
        self.init(
            title: article.title,
            description: article.description,
            author: article.author,
            url: article.url,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt,
            isFavourite: article.isFavourite
        )
    }
}
*/
