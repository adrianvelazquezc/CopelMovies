//
//  CM_MoviesMain.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

open class CM_MoviesMain{
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let viewController: CM_MoviesView? = CM_MoviesView()
        if let view = viewController {
            let presenter = CM_MoviesPresenter()
            let router = CM_MoviesRouter()
            let interactor = CM_MoviesInteractor()
            
            view.presenter = presenter
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            
            router.navigation = navigation
            router.presenter = presenter
            
            interactor.presenter = presenter
            return view
        }
        return UIViewController()
    }
}
