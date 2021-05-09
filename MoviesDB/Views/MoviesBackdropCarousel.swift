//
//  MoviesBackdropCarouselView.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

struct MoviesBackdropCarousel: View {
    
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
                            MovieBackdropCard(movie: movie)
                                .frame(width: 272, height: 180)
                                .padding(.leading, movie == movies.first! ? 16 : 0)
                                .padding(.trailing, movie == movies.last! ? 16 : 0)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
        }
    }
}

struct MoviesBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesBackdropCarousel(title: "Latest", movies: Movie.testMovies)
    }
}
