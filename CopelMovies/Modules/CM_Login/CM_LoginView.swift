//
//  CM_LoginView.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

class CM_LoginView: UIViewController {
    var presenter: CM_LoginPresenterProtocol?
    private var ui: CM_LoginViewUI?
    private var tempName = ""
    private var tempPassword = ""
    
    override func loadView() {
        ui = CM_LoginViewUI(
            navigation: self.navigationController ?? UINavigationController(),
            delegate: self
        )
        view = ui
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ui?.errorLabel.isHidden = true
    }
}

extension CM_LoginView: CM_LoginViewProtocol {
    
    func notifyError(error: String) {
        ui?.errorLabel.isHidden = false
        ui?.errorLabel.text = error
    }
    
    func showLoading() {
        CM_ActivityIndicator.show(parent: self.view)
    }
    
    func dissmissLoading() {
        CM_ActivityIndicator.remove(parent: self.view)
    }
}

extension CM_LoginView: CM_LoginViewUIDelegate {
    
    func notifyUserAndPassword(name: String, password: String) {
        self.tempName = name
        self.tempPassword = password
        self.presenter?.requestUserAndPassword(name: name, password: password)
    }
    
}
