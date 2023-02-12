//
//  FavouriteNewsRepository.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import Foundation

protocol FavouriteNewsRepository {
    mutating func fetchFavouriteNews() -> [URL]
    mutating func addFavourite(with url: URL)
    mutating func removeFavourite(with url: URL)
    mutating func clear()
}
