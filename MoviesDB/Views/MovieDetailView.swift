//
//  MovieDetailView.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    @EnvironmentObject var favouriteMoviesListState: FavouriteMoviesListState
    
    var movieIsFavourite: Bool {
        guard let movie = movieDetailState.movie else { return false }
        return favouriteMoviesListState.favouriteMovies.contains(movie)
    }
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: movieDetailState.isLoading, error: movieDetailState.error) {
                movieDetailState.loadMovie(id: movieId)
            }
            
            if let movie = movieDetailState.movie {
                MovieDetailListView(movie: movie)
                    .navigationBarItems(trailing: !movieIsFavourite ?
                                            Button(action: { favouriteMoviesListState.add(movie: movie) }, label: { Image(systemName: "star")}) :
                                            Button(action: { favouriteMoviesListState.delete(movie: movie) }, label: { Image(systemName: "trash")}))
                
            }
            
        }.navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            movieDetailState.loadMovie(id: movieId)
        }
    }
    
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.testMovie.id)
        }
    }
}



struct MovieDetailListView: View {
    
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 16) {
                
                MovieDetailImage(imageURL: movie.backdropURL, imageLoader: imageLoader)
                
                HStack {
                    Text(movie.genreText)
                    Text("·")
                    Text(movie.yearText)
                    Text(movie.durationText)
                }
                
                Text(movie.overview)
                
                HStack(spacing: 0) {
                    ForEach(0..<10) { i in
                        Text("★")
                            .foregroundColor(i < movie.rating ? .yellow : .secondary)
                    }
                    Text(movie.scoreText)
                        .padding(.leading)
                }
            }
            
            Divider()
                .padding(.vertical)
            
            HStack(alignment: .top, spacing: 4) {
                
                if let cast = movie.cast, cast.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring")
                            .font(.headline)
                        ForEach(cast.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                if let crew = movie.crew, crew.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if let directors = movie.directors, directors.count > 0 {
                            Text("Director(s)")
                                .font(.headline)
                            ForEach(directors.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if let producers = movie.producers, producers.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if let screenWriters = movie.screenWriters, screenWriters.count > 0 {
                            Text("Screenwriter(s)")
                                .font(.headline)
                                .padding(.top)
                            ForEach(screenWriters.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
            }
            
            Divider()
                .padding(.vertical)
            
            if let trailers = movie.youtubeTrailers, trailers.count > 0 {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("Trailers")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    ForEach(trailers) { trailer in
                        Button(action: {
                            selectedTrailer = trailer
                        }) {
                            HStack {
                                Text(trailer.name)
                                Spacer()
                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(Color(UIColor.systemBlue))
                            }
                        }
                    }
                    
                }
                
            }
        }.padding()
        .sheet(item: $selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
    }
}


struct MovieDetailImage: View {
    
    let imageURL: URL
    @ObservedObject var imageLoader: ImageLoader
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage())
            .resizable()
            .redacted(reason: imageLoader.image == nil ? .placeholder : .init())
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .onAppear {
                imageLoader.loadImage(with: imageURL)
            }
    }
    
}
