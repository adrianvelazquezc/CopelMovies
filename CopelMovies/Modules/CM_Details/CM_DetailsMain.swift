//
//  CM_DetailsMain.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation
import UIKit

open class CM_DetailsMain{
    public static func createModule(navigation: UINavigationController, movieId: Int, isFavoriteMovie: Bool) -> UIViewController {
        let viewController: CM_DetailsView? = CM_DetailsView()
        if let view = viewController {
            let presenter = CM_DetailsPresenter()
            let router = CM_DetailsRouter()
            let interactor = CM_DetailsInteractor()
            
            view.presenter = presenter
            view.movieID = movieId
            view.isFavoriteMovie = isFavoriteMovie
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            
            router.navigation = navigation
            
            interactor.presenter = presenter
            return view
        }
        return UIViewController()
    }
}
