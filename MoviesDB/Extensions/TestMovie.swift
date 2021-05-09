//
//  TestMovie.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 08.05.2021.
//

import Foundation

extension Movie {
    
    static var testMovies: [Movie] {
        let response: MoviesResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var testMovie: Movie {
        testMovies[0]
    }
    
}


extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
