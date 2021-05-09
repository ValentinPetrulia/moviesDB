//
//  MovieDetailState.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

class MovieDetailState: ObservableObject {
    
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService = MovieService.shared
    
    func loadMovie(id: Int) {
        movie = nil
        isLoading = false
        movieService.fetchMovie(id: id) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
