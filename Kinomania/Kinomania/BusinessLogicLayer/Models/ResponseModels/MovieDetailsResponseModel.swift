//
//  MovieDetailsResponseModel.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

struct MovieDetailsResponseModel: Decodable {
    let posterPath: String?
    let title: String
    let releaseDate: String
    let productionCountries: [ProductionCountriesResponseModel]
    let genres: [GenresResponseModel]
    let overview: String
    let voteAverage: Double
    let videos: VideoResponseModel?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case productionCountries = "production_countries"
        case genres
        case overview
        case voteAverage = "vote_average"
        case videos
    }
}

struct GenresResponseModel: Decodable {
    let name: String
    let id: Int
}

struct ProductionCountriesResponseModel: Decodable {
    let name: String
}

struct VideoResponseModel: Decodable {
    let results: [TrailerResults]
}

struct TrailerResults: Decodable {
    let key: String
}
