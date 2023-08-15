//
//  CM_DetailsPresenter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

class CM_DetailsPresenter {
    var interactor: CM_DetailsInteractorProtocol?
    weak var view: CM_DetailsViewProtocol?
    var router: CM_DetailsRouterProtocol?
    var movieId = 0
    var favorites: [Movie] = []
}



extension CM_DetailsPresenter: CM_DetailsPresenterProtocol {
    func requestMovieDetails(movieId: Int) {
        self.view?.showLoading()
        self.movieId = movieId
        self.interactor?.fetchMovieDetails(movieId: movieId)
    }
    
    func responseMovieDetails(movieDetails: MovieDetails) {
        self.view?.dissmissLoading()
        view?.notifyMovieDetails(movieDetails: movieDetails)
    }

    func requestFavoriteMovie(isFavorite: Bool, movieId: Int) {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
    
    func responseFavoriteMovie() {
        self.view?.dissmissLoading()
    }
    
    func requestDeleteSession() {
        self.view?.showLoading()
        self.interactor?.postDeleteSession()
    }
    
    func responseDeletedSession() {
        self.view?.dissmissLoading()
        self.router?.navigateCloseSession()
    }
    
    func requestFavoritesWithPresent() {
        self.view?.showLoading()
        self.interactor?.fetchFavoritesWithPresent()
    }
    
    func responseFavoritesWithPresent(list: [Movie]) {
        self.view?.dissmissLoading()
        self.view?.notifyShowProfile(list: list)
    }
    
    func responseError(error: String, step: ListService) {
        self.view?.dissmissLoading()
        view?.notifyError(error: error, step: step)
    }
    
}
