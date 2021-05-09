//
//  RootView.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 09.05.2021.
//

import SwiftUI

struct RootView: View {
    
    var favouriteMoviesListState = FavouriteMoviesListState()
    
    var body: some View {
        
        TabView {
            
            MovieListView()
                .tabItem {
                    Image(systemName: "play.tv.fill")
                    Text("Movies")
                }
            
            FavouriteMoviesListView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }
            
            MovieSearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
        }.environmentObject(favouriteMoviesListState)
        
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
