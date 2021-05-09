//
//  MoviePosterCard.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

struct MoviePosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var imageIsEmpty: Bool {
        imageLoader.image == nil
    }
    
    var body: some View {
        
        ZStack {
            
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .cornerRadius(8)
                .shadow(radius: 4)
                .redacted(reason: imageIsEmpty ? .placeholder : .init())
            
            if imageIsEmpty {
                Text(movie.title)
                    .fontWeight(.medium)
            }
            
        }.onAppear {
            imageLoader.loadImage(with: movie.posterURL)
        }
        
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.testMovies[1])
    }
}
