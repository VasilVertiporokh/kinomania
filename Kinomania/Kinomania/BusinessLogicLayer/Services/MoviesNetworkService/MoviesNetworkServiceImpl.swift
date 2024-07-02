//
//  MoviesNetworkServiceImpl.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

typealias GetMoviesResult = DataResult<MoviesResponseModel>
typealias GetGenresResult = DataResult<GenresResponseModel>
typealias GetDetailsResult = DataResult<MovieDetailsResponseModel>

protocol MoviesNetworkService {
    func getMovies(pageNumber: String, filter: Filter, result: @escaping GetMoviesResult)
    func getMovieDetails(id: Int, result: @escaping GetDetailsResult)
    func getMovie(name: String, result: @escaping GetMoviesResult)
    func getGenres(result: @escaping GetGenresResult)
}

final class MoviesNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol> where NetworkProvider.Endpoint == MoviesNetworkEndpoinBuilder {
    // MARK: - Private properties
    private let provider: NetworkProvider

    // MARK: - Init
    init(provider: NetworkProvider) {
        self.provider = provider
    }
}

// MARK: - MoviesNetworkService
extension MoviesNetworkServiceImpl: MoviesNetworkService {
    func getMovies(pageNumber: String, filter: Filter, result: @escaping GetMoviesResult) {
        provider.performWithResponseModel(
            .getMovies(page: pageNumber, filter: filter),
            response: MoviesResponseModel.self,
            responseHandler: result
        )
    }

    func getMovieDetails(id: Int, result: @escaping GetDetailsResult) {
        provider.performWithResponseModel(
            .getMovieDetails(id: id),
            response: MovieDetailsResponseModel.self,
            responseHandler: result
        )
    }

    func getMovie(name: String, result: @escaping GetMoviesResult) {
        provider.performWithResponseModel(
            .getMoviesBy(name: name, page: "1"),
            response: MoviesResponseModel.self,
            responseHandler: result
        )
    }

    func getGenres(result: @escaping GetGenresResult) {
        provider.performWithResponseModel(
            .getGenres,
            response: GenresResponseModel.self,
            responseHandler: result
        )
    }
}
