//
//  CM_DetailsRouter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

class CM_DetailsRouter{
    var navigation: UINavigationController?
    weak var presenter: CM_DetailsPresenter?
}

extension CM_DetailsRouter: CM_DetailsRouterProtocol{
    func navigateCloseSession() {
        self.navigation?.popToRootViewController(animated: true)
    }
    
    func navigatePresent(delegate: CM_ProfilePresentDelegate, list: [Movie]) {
        let profileController = CM_ProfilePresent()
        profileController.movieList = list
        profileController.delegate = delegate
        self.navigation?.present(profileController, animated: true, completion: nil)
    }
}
