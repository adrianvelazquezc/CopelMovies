//
//  CM_LoginPresenter.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

class CM_LoginPresenter {
    var interactor: CM_LoginInteractorProtocol?
    weak var view: CM_LoginViewProtocol?
    var router: CM_LoginRouterProtocol?
}

extension CM_LoginPresenter: CM_LoginPresenterProtocol {
    func requestUserAndPassword(name: String, password: String) {
        self.view?.showLoading()
        self.interactor?.fetchToken(name: name, password: password)
    }
    
    func responseUserAndPassword() {
        self.view?.dissmissLoading()
        self.router?.navigateToNextView()
    }
    
    func responseError(error: String) {
        self.view?.dissmissLoading()
        self.view?.notifyError(error: error)
    }
}
