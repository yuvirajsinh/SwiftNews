//
//  Article.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import Foundation

protocol Article {
    //var id: UUID { get set }
    var title: String { get set }
    var description: String? { get set }
    var author: String? { get set }
    var url: URL { get set }
    var urlToImage: URL? { get set }
    var publishedAt: Date { get set }
    var isFavourite: Bool { get set }
}

//extension Article {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.url == rhs.url
//    }
//}
