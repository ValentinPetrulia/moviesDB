//
//  FavouriteMoviesListView.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 09.05.2021.
//

import SwiftUI

struct FavouriteMoviesListView: View {
    
    @EnvironmentObject var favouriteMoviesListState: FavouriteMoviesListState
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favouriteMoviesListState.favouriteMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text(movie.yearText)
                                .font(.subheadline)
                        }
                    }
                }.onDelete(perform: deleteFavouriteMovie)
            }.navigationBarTitle("Favourites")
        }
    }
    
   private func deleteFavouriteMovie(at offsets: IndexSet) {
        for offset in offsets {
            let movie = favouriteMoviesListState.favouriteMovies[offset]
            favouriteMoviesListState.delete(movie: movie)
        }
    }

}

struct FavouriteMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMoviesListView()
    }
}
