//
//  CM_MoviesView.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

class CM_MoviesView: UIViewController {
    var presenter: CM_MoviesPresenterProtocol?
    private var ui: CM_MoviesViewUI?
    internal var isFavorite = false
    
    override func loadView() {
        ui = CM_MoviesViewUI(
            navigation: self.navigationController ?? UINavigationController(),
            delegate: self
        )
        view = ui
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.requestFavoriteList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.requestFavoriteList()
    }
    
}

extension CM_MoviesView: CM_MoviesViewProtocol {
    func notifyAddDeleteFavoriteList(wasFavorite: Bool) {
        if wasFavorite {
            if let currentMovieId = ui?.currentMovieId {
                ui?.favoriteMovieIDs.insert(currentMovieId)
            }
        } else {
            if let currentMovieId = ui?.currentMovieId {
                ui?.favoriteMovieIDs.remove(currentMovieId)
            }
        }
    }
    
    func notifyError(error: String, step: ListService) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { action in
            switch step {
            case .getmoviesList:
                self.presenter?.requestMovieList(gender: self.ui?.valueSelected ?? MoviesCategories.popular)
                break
            case .getFavoritesMovies:
                self.presenter?.requestFavoriteList()
                break
            case .updateFavoriteMovie:
                break
            case .deleteSession:
                self.presenter?.requestDeleteSession()
                break
            case .getmovieDetails:
                break
            case .getFavoritesWithPresent:
                self.presenter?.requestFavoritesWithPresent()
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func notifyFavoriteList() {
        self.presenter?.requestMovieList(gender: ui?.valueSelected ?? MoviesCategories.popular)
    }
    
    func showLoading() {
        CM_ActivityIndicator.show(parent: self.view)
    }
    
    func dissmissLoading() {
        CM_ActivityIndicator.remove(parent: self.view)
    }
    
    func notifyMovieList(list: [Pelicula], favoriteList: [Pelicula]) {
        self.ui?.movieList = list
        for favorite in favoriteList {
            ui?.favoriteMovieIDs.insert(favorite.id ?? 0)
        }
        self.ui?.collectionView.reloadData()
        self.ui?.collectionView.layoutIfNeeded()
    }
    func notifyMovieList(list: [Pelicula], favoriteList: [Pelicula], favoriteMovieIDs: Set<Int>) {
        self.ui?.movieList = list
        self.ui?.favoriteList = favoriteList
        self.ui?.favoriteMovieIDs = favoriteMovieIDs
        self.ui?.collectionView.reloadData()
        self.ui?.collectionView.layoutIfNeeded()
    }
    
    func notifyShowProfile(list: [Pelicula]) {
        self.presenter?.requestPresent(delegate: self, list: list)
    }
    
}

extension CM_MoviesView: CM_MoviesViewUIDelegate {
    func refreshMovies() {
        self.presenter?.requestFavoriteList()
    }
    
    func notifyMoviesDetails(movieId: Int, isFavoriteMovie: Bool) {
        self.presenter?.requestMoviesDetails(movieId: movieId, isFavoriteMovie: isFavoriteMovie)
    }
    
    func notifyMenuPressed() {
        let alertController = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "View Profile", style: .default) { _ in
            self.presenter?.requestFavoritesWithPresent()
        }
        alertController.addAction(action1)
        let action2 = UIAlertAction(title: "Log out", style: .destructive) { _ in
            self.presenter?.requestDeleteSession()
        }
        alertController.addAction(action2)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func notifyGenderSelected() {
        self.presenter?.requestMovieList(gender: ui?.valueSelected ?? MoviesCategories.popular)
    }
    
    func notifyUpdateFavorite(isFavorite: Bool, movieId: Int) {
        self.isFavorite = isFavorite
        self.presenter?.requestFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
}

extension CM_MoviesView: CM_ProfilePresentDelegate {
    func willDissmiss(deletedId: Set<Int>) {
        self.presenter?.requestFavoriteList()
    }
}
