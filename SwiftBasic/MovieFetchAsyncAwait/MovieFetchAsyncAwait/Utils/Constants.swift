//
//  File.swift
//  MovieFetchAsyncAwait
//
//  Created by 김광수 on 2021/12/18.
//

import Foundation

struct Constants {
    
    struct ApiKeys {
        static let omdbIdKey = "2b7675ce"
    }
    
    struct Urls {
        static func urlBySearch(search: String) -> String {
            "http://www.omdbapi.com/?s=\(search)&page=1&apikey=\(ApiKeys.omdbIdKey)"
        }
        
        static func urlForMovieDetailsByImdbId(imdbId: String) -> String {
            "http://www.omdbapi.com/?i=\(imdbId)&apikey=\(ApiKeys.omdbIdKey)"
        }
    }
}
