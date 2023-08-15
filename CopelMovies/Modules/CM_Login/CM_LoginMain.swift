//
//  CM_LoginMain.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

open class CM_LoginMain{
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let viewController: CM_LoginView? = CM_LoginView()
        if let view = viewController {
            let presenter = CM_LoginPresenter()
            let router = CM_LoginRouter()
            let interactor = CM_LoginInteractor()
            
            view.presenter = presenter
            
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
