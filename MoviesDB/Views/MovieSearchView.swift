//
//  MovieSearchView.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 09.05.2021.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                SearchBarView(placeholder: "Search movies", text: $movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: movieSearchState.isLoading, error: movieSearchState.error) {
                    movieSearchState.search(query: movieSearchState.query)
                }
                
                if let movies = movieSearchState.movies {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.yearText)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                
            }
            .onAppear {
                movieSearchState.startObserve()
            }
            .navigationBarTitle("Search")
        }
    }
}


struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
