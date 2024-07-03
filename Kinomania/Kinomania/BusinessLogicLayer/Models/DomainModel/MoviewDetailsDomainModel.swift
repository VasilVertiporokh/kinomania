//
//  MoviewDetailsDomainModel.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import Foundation

struct MoviewDetailsDomainModel {
    let posterPath: String
    let title: String
    let releaseDate: String
    let productionCountries: String
    let genres: String
    let overview: String
    let voteAverage: Double
    let videoKey: String?

    var posterUrl: URL? { .init(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") }

    var shortDate: String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else {
            return ""
        }
        return "\(calendar.component(.year, from: date))"
    }
    
    var isVideoAvailable: Bool { videoKey != nil }

    // MARK: - Init from response model
    init(responseModel: MovieDetailsResponseModel) {
        self.posterPath = responseModel.posterPath ?? ""
        self.title = responseModel.title
        self.releaseDate = responseModel.releaseDate
        self.productionCountries = responseModel.productionCountries
            .map { $0.name }
            .joined(separator: " ")
        self.genres = responseModel
            .genres.map { $0.name }
            .joined(separator: ", ")
        self.overview = responseModel.overview
        self.voteAverage = responseModel.voteAverage
        self.videoKey = responseModel.videos?.results.first?.key
    }
}
