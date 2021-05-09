//
//  MovieBackdropCard.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .aspectRatio(16/9, contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 4)
                .redacted(reason: imageLoader.image == nil ? .placeholder : .init())
            
            Text(movie.title)
                .fontWeight(.medium)
                .lineLimit(1)
            
        }.onAppear {
            imageLoader.loadImage(with: movie.backdropURL)
        }
        
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.testMovie)
    }
}
