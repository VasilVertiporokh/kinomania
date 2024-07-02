//
//  MovieDetailsResponseModel.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

struct MovieDetailsResponseModel: Decodable {
    let id: Int
    let posterPath: String
    let title: String
    let releaseDate: String
    let productionCountries: [ProductionCountriesResponseModeI]
    let genres: [GenresResponseModel]
    let overview: String
    let voteAverage: Double
    let videos: VideoResponseModel?
}

struct GenresResponseModel: Decodable {
    let name: String
}

struct ProductionCountriesResponseModeI: Decodable {
    let name: String
}

struct VideoResponseModel: Decodable {
    let results: [TrailerResults]
}

struct TrailerResults: Decodable {
    let key: String
}
