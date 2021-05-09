//
//  MovieListState.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

class MovieListState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService = MovieService.shared
    
    func loadMovies(endpoint: MoviesListEndpoint) {
        movies = nil
        isLoading = false
        movieService.fetchMovies(from: endpoint) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = true
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}
