//
//  MovieService.swift
//  MoviesDB
//
//  Created by Валентин Петруля on 05.05.2021.
//

import Foundation

class MovieService {
    static let shared = MovieService()
    private let apiKey = "54cae581e0754473581fa1dbbaee4753"
    private let baseURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    private init() {}
    
    
    private func loadURLAndDecode<D: Decodable>(url: URL, parameters: [String: String]? = nil, completion: @escaping(Result<D, MovieError>) -> ()) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let parameters = parameters {
            queryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                DispatchQueue.main.sync {
                    completion(.success(decodedResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.serializationError))
                }
            }
            
        }.resume()
        
    }
}


extension MovieService: MovieAPICaller {
    
    func fetchMovies(from endpoint: MoviesListEndpoint, completion: @escaping (Result<MoviesResponse, MovieError>) -> ()) {
        let stringURL = "\(baseURL)/movie/\(endpoint.rawValue)"
        guard let url = URL(string: stringURL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        let stringURL = "\(baseURL)/movie/\(id)"
        guard let url = URL(string: stringURL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url,
                                          parameters: ["append_to_response" : "videos,credits"],
                                          completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, MovieError>) -> ()) {
        let stringURL = "\(baseURL)/search/movie"
        guard let url = URL(string: stringURL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url,
                                          parameters: ["language" : "en-US",
                                                                "include_adult": "false",
                                                                "region": "US",
                                                                "query": query],
                                          completion: completion)
    }
    
}
