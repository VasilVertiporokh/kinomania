//
//  MoviesResponseModel.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

// MARK: - MoviesResponseModel
struct MoviesResponseModel: Decodable {
    let page: Int
    let results: [Movies]
}

// MARK: - Movies
struct Movies: Decodable {
    let genreIDS: [Int]
    let id: Int
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
    }
}
