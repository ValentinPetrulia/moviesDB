//
//  MoviesPosterCarousel.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

struct MoviesPosterCarousel: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MoviePosterCard(movie: movie)
                                .frame(width: 200, height: 300)
                                .padding(.leading, movie == movies.first! ? 16 : 0)
                                .padding(.trailing, movie == movies.last! ? 16 : 0)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
        }
    }
    
}


struct MoviesPosterCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MoviesPosterCarousel(title: "New", movies: Movie.testMovies)
    }
}
