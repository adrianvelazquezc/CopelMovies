//
//  CM_DetailsView.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

class CM_DetailsView: UIViewController {
    var presenter: CM_DetailsPresenterProtocol?
    private var ui: CM_DetailsViewUI?
    internal var movieID: Int = 0
    internal var isFavoriteMovie = false
    
    override func loadView() {
        ui = CM_DetailsViewUI(
            navigation: self.navigationController ?? UINavigationController(),
            delegate: self,
            movieId: self.movieID,
            isFavoriteMovie: isFavoriteMovie
        )
        view = ui
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.requestMovieDetails(movieId: self.movieID)
    }
}

extension CM_DetailsView: CM_DetailsViewProtocol {
    func notifyShowProfile(list: [Pelicula]) {
        let profileController = CM_ProfilePresent()
        profileController.movieList = list
        profileController.delegate = self
        self.present(profileController, animated: true, completion: nil)
    }
    
    func notifyMovieDetails(movieDetails: MovieDetails) {
        ui?.updateValues(movieDetails: movieDetails, isFavorite: isFavoriteMovie)
    }
    
    func notifyError(error: String, step: ListService) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { action in
            switch step {
            case .getmoviesList:
                break
            case .getFavoritesMovies:
                break
            case .updateFavoriteMovie:
                self.presenter?.requestFavoriteMovie(isFavorite: self.isFavoriteMovie, movieId: self.movieID)
                break
            case .deleteSession:
                self.presenter?.requestDeleteSession()
                break
            case .getmovieDetails:
                self.presenter?.requestMovieDetails(movieId: self.movieID)
                break
            case .getFavoritesWithPresent:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        CM_ActivityIndicator.show(parent: self.view)
    }
    
    func dissmissLoading() {
        CM_ActivityIndicator.remove(parent: self.view)
    }
    
}

extension CM_DetailsView: CM_DetailsViewUIDelegate {
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
    
    func notifyBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func notifyUpdateFavorite(isFavorite: Bool, movieId: Int) {
        self.isFavoriteMovie = isFavorite
        self.presenter?.requestFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
}

extension CM_DetailsView: CM_ProfilePresentDelegate {
    func willDissmiss(deletedId: Set<Int>) {
        if deletedId.contains(self.movieID) {
            
            ui?.favoriteButton.tintColor = .white
            ui?.favoriteButton.setImage(UIImage(named: "favoriteIcon"), for: .normal)
        }
        self.presenter?.requestMovieDetails(movieId: self.movieID)
    }
}
