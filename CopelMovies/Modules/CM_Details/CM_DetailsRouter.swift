//
//  CM_DetailsRouter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation
import UIKit

class CM_DetailsRouter{
    var navigation: UINavigationController?
}

extension CM_DetailsRouter: CM_DetailsRouterProtocol{
    func navigateCloseSession() {
        self.navigation?.popToRootViewController(animated: true)
    }
}
