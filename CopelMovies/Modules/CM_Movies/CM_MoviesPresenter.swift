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
    var favorites: [Movie] = []
    var currentGender: MoviesCategories?
}



extension CM_MoviesPresenter: CM_MoviesPresenterProtocol {
    func requestMovieList(gender: MoviesCategories) {
        self.view?.showLoading()
        self.interactor?.fetchMovieList(gender: gender)
    }
    
    func responseMovieList(_ list: [Movie]) {
        self.view?.dissmissLoading()
        var favoriteMovieIDs: Set<Int> = []
        for favorite in self.favorites {
            favoriteMovieIDs.insert(favorite.id ?? 0)
        }
        view?.notifyMovieList(list: list, favoriteList: self.favorites, favoriteMovieIDs: favoriteMovieIDs)
    }
    
    func requestMoviesDetails(movieId: Int, isFavoriteMovie: Bool) {
        self.router?.navigateMovieDetails(movieId: movieId, isFavoriteMovie: isFavoriteMovie)
    }
    
    func requestFavoriteList() {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteListMovies()
    }
    
    func responseFavoriteList(list: [Movie]) {
        self.favorites = list
        self.view?.notifyFavoriteList()
    }
    
    func requestDeleteSession() {
        self.view?.showLoading()
        self.interactor?.postDeleteSession()
    }
    
    func responseDeletedSession() {
        self.view?.dissmissLoading()
        self.router?.navigateCloseSession()
    }
    
    func requestFavoriteMovie(isFavorite: Bool, movieId: Int) {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
    
    func responseFavoriteMovie() {
        self.view?.dissmissLoading()
        self.view?.notifyAddDeleteFavoriteList()
    }
    
    func requestFavoritesWithPresent() {
        self.view?.showLoading()
        self.interactor?.fetchFavoritesWithPresent()
    }
    
    func responseFavoritesWithPresent(list: [Movie]) {
        self.view?.dissmissLoading()
        self.view?.notifyShowProfile(list: list)
    }
    func requestPresent(delegate: CM_ProfilePresentDelegate, list: [Movie]) {
        self.router?.navigatePresent(delegate: delegate, list: list)
    }
    
    func responseError(error: String, step: ListService) {
        self.view?.dissmissLoading()
        self.view?.notifyError(error: error, step: step)
    }
}
