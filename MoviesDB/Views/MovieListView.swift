//
//  MovieListView.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 32) {
                    
                    if let nowPlayingMovies = nowPlayingState.movies {
                        MoviesPosterCarousel(title: "Now Playing", movies: nowPlayingMovies)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            nowPlayingState.loadMovies(endpoint: .nowPlaying)
                        }
                    }
                
                    if let upcomingMovies = upcomingState.movies {
                        MoviesBackdropCarousel(title: "Upcoming", movies: upcomingMovies)
                    } else {
                        LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                            upcomingState.loadMovies(endpoint: .upcoming)
                        }
                    }
                
                    if let topRatedMovies = topRatedState.movies {
                        MoviesBackdropCarousel(title: "Top Rated", movies: topRatedMovies)
                    } else {
                        LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                            topRatedState.loadMovies(endpoint: .topRated)
                        }
                    }
                
                    if let popularMovies = popularState.movies {
                        MoviesBackdropCarousel(title: "Popular", movies: popularMovies)
                    } else {
                        LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                            popularState.loadMovies(endpoint: .popular)
                        }
                    }
                    
                }
                
            }.navigationBarTitle("Movies")
            .padding(.vertical)
            .onAppear(perform: loadMovies)
            
        }
        
    }
    
    private func loadMovies() {
        nowPlayingState.loadMovies(endpoint: .nowPlaying)
        upcomingState.loadMovies(endpoint: .upcoming)
        topRatedState.loadMovies(endpoint: .topRated)
        popularState.loadMovies(endpoint: .popular)
    }
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
