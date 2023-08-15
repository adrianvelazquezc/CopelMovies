//
//  CM_DetailsProtocols.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

protocol CM_DetailsViewProtocol: AnyObject {
    func notifyMovieDetails(movieDetails: MovieDetails)
    func notifyError(error: String, step: ListService)
    func showLoading()
    func dissmissLoading()
    func notifyShowProfile(list: [Pelicula])
}

protocol CM_DetailsInteractorProtocol: AnyObject {
    func fetchMovieDetails(movieId: Int)
    func fetchFavoriteMovie(isFavorite: Bool, movieId: Int)
    func postDeleteSession()
    func fetchFavoritesWithPresent()
}

protocol CM_DetailsPresenterProtocol: AnyObject {
    func requestMovieDetails(movieId: Int)
    func responseMovieDetails(movieDetails: MovieDetails)
    func requestFavoriteMovie(isFavorite: Bool, movieId: Int)
    func responseFavoriteMovie()
    func requestDeleteSession()
    func responseDeletedSession()
    func requestFavoritesWithPresent()
    func responseFavoritesWithPresent(list: [Pelicula])
    func responseError(error: String, step: ListService)
}

protocol CM_DetailsRouterProtocol: AnyObject {
    func navigateCloseSession()
}
