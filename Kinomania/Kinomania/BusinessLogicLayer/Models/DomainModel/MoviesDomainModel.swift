//
//  MoviesDomainModel.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

struct MoviesDomainModel {
    var genres: [GenresResponseModel] = []
    let genreIDS: [Int]
    let id: Int
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double

    var genresString: String {
        genres
            .filter { genreIDS.contains($0.id) }
            .map { $0.name }
            .joined(separator: ", ")
    }

    var posterUrl: URL? { .init(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") }

    // MARK: - Init from response model
    init(genres: [GenresResponseModel], moviesResponseModel: Movies) {
        self.genres = genres
        self.genreIDS = moviesResponseModel.genreIDS
        self.id = moviesResponseModel.id
        self.posterPath = moviesResponseModel.posterPath
        self.releaseDate = moviesResponseModel.releaseDate
        self.title = moviesResponseModel.title
        self.video = moviesResponseModel.video
        self.voteAverage = moviesResponseModel.voteAverage
    }
}
