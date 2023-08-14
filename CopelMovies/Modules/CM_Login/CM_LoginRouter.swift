//
//  CM_LoginRouter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation
import UIKit

class CM_LoginRouter{
    var navigation: UINavigationController?
}

extension CM_LoginRouter: CM_LoginRouterProtocol{
    func navigateToNextView() {
        if let navigationController = self.navigation{
            let vc = CM_MoviesMain.createModule(navigation: navigationController)
            navigationController.pushViewController(vc, animated: true )
        }
    }
}
