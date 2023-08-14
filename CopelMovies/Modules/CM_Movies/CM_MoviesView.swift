//
//  CM_MoviesView.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation
import UIKit

class CM_MoviesView: UIViewController {
    var presenter: CM_MoviesPresenterProtocol?
    private var ui: CM_MoviesViewUI?
    
    override func loadView() {
        ui = CM_MoviesViewUI(
            navigation: self.navigationController ?? UINavigationController(),
            delegate: self
        )
        view = ui
    }
}

extension CM_MoviesView: CM_MoviesViewProtocol {
    func showLoading() {
        CM_ActivityIndicator.show(parent: self.view)
    }
    
    func dissmissLoading() {
        CM_ActivityIndicator.remove(parent: self.view)
    }
}

extension CM_MoviesView: CM_MoviesViewUIDelegate {
    
}
