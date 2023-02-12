//
//  FavouriteDataManager.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

struct FavouriteDataManager {
    private var favouriteNewsDataRepository: FavouriteNewsRepository = FavouriteNewsDataRepository()

    mutating func fetchFavouriteNews() -> [URL] {
        return favouriteNewsDataRepository.fetchFavouriteNews()
    }

    mutating func addFavourite(with url: URL) {
        favouriteNewsDataRepository.addFavourite(with: url)
    }

    mutating func removeFavourite(with url: URL) {
        favouriteNewsDataRepository.removeFavourite(with: url)
    }

    mutating func clear() {
        favouriteNewsDataRepository.clear()
    }
}
