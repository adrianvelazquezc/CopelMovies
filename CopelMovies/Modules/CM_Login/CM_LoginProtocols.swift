//
//  CM_LoginProtocols.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

protocol CM_LoginViewProtocol: AnyObject {
    func notifyError(error: String)
    func showLoading()
    func dissmissLoading()
}

protocol CM_LoginInteractorProtocol: AnyObject {
    func fetchToken(name: String, password: String)
    func fetchUserAndPassword(name: String, password: String)
    func authenticateToken()
}

protocol CM_LoginPresenterProtocol: AnyObject {
    func requestUserAndPassword(name: String, password: String)
    func responseUserAndPassword()
    func responseError(error: String)
}

protocol CM_LoginRouterProtocol: AnyObject {
    func navigateToNextView()
}
