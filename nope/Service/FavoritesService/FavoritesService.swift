//
//  FavoritesService.swift
//  nope
//
//  Created by Sushant Verma on 18/2/2026.
//

import Combine

protocol FavoritesService {
    var favorites: [String] { get }
    var favoritesPublisher: AnyPublisher<[String], Never> { get }

    func has(message: String) -> Bool

    @discardableResult
    func addFavorite(message: String) -> Bool

    @discardableResult
    func removeFavorite(message: String) -> Bool
}
