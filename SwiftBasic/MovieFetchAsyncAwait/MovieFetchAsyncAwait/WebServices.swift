//
//  WebServices.swift
//  MovieFetchAsyncAwait
//
//  Created by 김광수 on 2021/12/18.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
    case httpCode(Int)
}

class WebService {
    
    func getMoviesBy(search: String) async throws -> [Movie] {
        
        guard let moviesURL = URL(string: Constants.Urls.urlBySearch(search: search)) else {
            throw NetworkError.badURL
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: moviesURL) else {
            throw NetworkError.badURL
        }
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.noData }
        guard let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
            throw NetworkError.decodingError
        }
        return movieResponse.movies
    }
    
}
