//
//  FavouriteMoviesListState.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 09.05.2021.
//

import SwiftUI

class FavouriteMoviesListState: ObservableObject {
    @Published var favouriteMovies: [Movie]
    
    init() {
        favouriteMovies = []
    }
    
    func add(movie: Movie) {
        favouriteMovies.append(movie)
    }
    
    func delete(movie: Movie) {
        while favouriteMovies.contains(movie) {
            if let itemToRemoveIndex = favouriteMovies.firstIndex(of: movie) {
                favouriteMovies.remove(at: itemToRemoveIndex)
            }
        }
    }
    
}
