//
//  MoviesNetworkEndpoinBuilder.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

enum Filter: String {
    case popularity = "popularity"
    case releaseDate = "primary_release_date.desc"
}

enum MoviesNetworkEndpoinBuilder {
    case getMovies(page: String, filter: Filter)
    case getMovieDetails(id: Int)
    case getMoviesBy(name: String, page: String)
    case getGenres
}

extension MoviesNetworkEndpoinBuilder: EndpointBuilderProtocol {
    var path: String {
        switch self {
        case .getMovies:
            return "3/discover/movie"
        case .getMovieDetails(let id):
            return "3/movie/\(id)"
        case .getMoviesBy:
            return "3/search/movie"
        case .getGenres:
            return "3/genre/movie/list"
        }
    }

    var method: HTTPMethod { .get }

    var query: [String : String]? {
        switch self {
        case .getMovies(let page, let filter):
            return [
                "page": "\(page)",
                "sort_by": filter.rawValue
            ]
        case .getMoviesBy(let name, let page):
            return [
                "page": page,
                "query" : name
            ]
        case .getMovieDetails:
            return [
                "append_to_response": "videos"
            ]
        case .getGenres:
            return nil
        }
    }
}
