//
//  CM_MoviesPresenter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

class CM_MoviesPresenter {
    var interactor: CM_MoviesInteractorProtocol?
    weak var view: CM_MoviesViewProtocol?
    var router: CM_MoviesRouterProtocol?
}



extension CM_MoviesPresenter: CM_MoviesPresenterProtocol {
    func requestMovieList(gender: MoviesCategories) {
        self.view?.showLoading()
        self.interactor?.fetchMovieList(gender: gender)
    }
    
    func responseMovieList(_ list: [Pelicula]) {
        self.view?.dissmissLoading()
        print("pasar a la vista de peliculas")
    }
    
    func requestMoviesDetails(movieId: Int, isFavoriteMovie: Bool) {
        print("ir al detalle de la pelicula")
    }
    
    func requestFavoriteList() {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteListMovies()
    }
    
    func responseFavoriteList(list: [Pelicula]) {
        print("marcar desmarcar favorito")
    }
    
    func requestDeleteSession() {
        self.view?.showLoading()
        self.interactor?.postDeleteSession()
    }
    
    func responseDeletedSession() {
        self.view?.dissmissLoading()
        print("cerrar sesion")
    }
    
    func requestFavoriteMovie(isFavorite: Bool, movieId: Int) {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
    
    func responseFavoriteMovie() {
        self.view?.dissmissLoading()
    }
    
    func requestFavoritesWithPresent() {
        self.view?.showLoading()
        self.interactor?.fetchFavoritesWithPresent()
    }
    
    func responseFavoritesWithPresent(list: [Pelicula]) {
        self.view?.dissmissLoading()
        print("hacer el present del perfil")
    }
    
    func responseError(error: String, step: ListService) {
        self.view?.dissmissLoading()
        print("manejar error")
    }
}
