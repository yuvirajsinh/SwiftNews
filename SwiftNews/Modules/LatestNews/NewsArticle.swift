//
//  Article.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 09/02/23.
//

import Foundation

struct NewsArticle: Article, Codable {
    //var id = UUID()
    var title: String
    var description: String?
    var author: String?
    var url: URL
    var urlToImage: URL?
    var publishedAt: Date
    var isFavourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author
        case url
        case urlToImage
        case publishedAt
    }
}

extension NewsArticle {
    static var example: Article {
        return NewsArticle(
            title: "News title",
            description: "News description",
            author: "BBC",
            url: URL(string: "https://google.com")!,
            urlToImage: URL(string: "https://ichef.bbci.co.uk/news/1024/branded_news/DEA5/production/_128579965_gettyimages-1246788286.jpg")!,
            publishedAt: Date()
        )
    }
}
