//
//  CM_MoviesRouter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

class CM_MoviesRouter{
    var navigation: UINavigationController?
    weak var presenter: CM_MoviesPresenter?
}

extension CM_MoviesRouter: CM_MoviesRouterProtocol{
    
    func navigateCloseSession() {
        self.navigation?.popToRootViewController(animated: true)
    }
    
    func navigateMovieDetails(movieId: Int, isFavoriteMovie: Bool) {
        if let navigationController = self.navigation{
            let vc = CM_DetailsMain.createModule(navigation: navigationController, movieId: movieId, isFavoriteMovie: isFavoriteMovie)
            navigationController.pushViewController(vc, animated: true )
        }
    }
    func navigatePresent(delegate: CM_ProfilePresentDelegate, list: [Pelicula]) {
        let profileController = CM_ProfilePresent()
        profileController.movieList = list
        profileController.delegate = delegate
        self.navigation?.present(profileController, animated: true, completion: nil)
    }
}
