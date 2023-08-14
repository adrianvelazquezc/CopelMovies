//
//  CM_MoviesProtocols.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

protocol CM_MoviesViewProtocol: AnyObject {
    func showLoading()
    func dissmissLoading()
}

protocol CM_MoviesInteractorProtocol: AnyObject {
    func fetchMovieList(gender: MoviesCategories)
    func fetchFavoriteListMovies()
    func postDeleteSession()
    func fetchFavoriteMovie(isFavorite: Bool, movieId: Int)
    func fetchFavoritesWithPresent()
}

protocol CM_MoviesPresenterProtocol: AnyObject {
    func requestMovieList(gender: MoviesCategories)
    func responseMovieList(_ list: [Pelicula])
    func requestMoviesDetails(movieId: Int, isFavoriteMovie: Bool)
    func requestFavoriteList()
    func responseFavoriteList(list: [Pelicula])
    func requestDeleteSession()
    func responseDeletedSession()
    func requestFavoriteMovie(isFavorite: Bool, movieId: Int)
    func responseFavoriteMovie()
    func requestFavoritesWithPresent()
    func responseFavoritesWithPresent(list: [Pelicula])
    func responseError(error: String, step: ListService)
}

protocol CM_MoviesRouterProtocol: AnyObject {
    
}
