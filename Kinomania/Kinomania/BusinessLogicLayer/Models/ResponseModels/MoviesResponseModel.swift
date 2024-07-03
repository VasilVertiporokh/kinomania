//
//  MoviesResponseModel.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

// MARK: - MoviesResponseModel
struct MoviesResponseModel: Decodable {
    let results: [Movies]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}

// MARK: - Movies
struct Movies: Decodable {
    let genreIDS: [Int]
    let id: Int
    var posterPath: String?
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
