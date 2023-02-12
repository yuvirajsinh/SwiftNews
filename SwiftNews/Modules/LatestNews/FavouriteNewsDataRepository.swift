//
//  FavouriteNewsDataRepository.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

struct FavouriteNewsDataRepository: FavouriteNewsRepository {
    private let filePath: URL = {
        FileManager.documentsDirectory.appending(path: "favoutes")
    }()

    private var favourites: [URL] = []

    mutating func fetchFavouriteNews() -> [URL] {
        do {
            let data = try Data(contentsOf: filePath)
            favourites = try JSONDecoder().decode([URL].self, from: data)
        } catch {
            favourites = []
        }
        return favourites
    }

    mutating func addFavourite(with url: URL) {
        favourites.append(url)
        save()
    }

    mutating func removeFavourite(with url: URL) {
        favourites.removeAll(where: { $0 == url })
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(favourites)
            try data.write(to: filePath, options: [.atomic, .completeFileProtection])
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    mutating func clear() {
        favourites.removeAll()
        save()
    }
}
