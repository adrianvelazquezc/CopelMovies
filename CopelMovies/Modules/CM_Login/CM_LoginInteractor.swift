//
//  CM_LoginInteractor.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

class CM_LoginInteractor{
    var presenter: CM_LoginPresenterProtocol?
}

extension CM_LoginInteractor: CM_LoginInteractorProtocol {
    func fetchToken(name: String, password: String) {
        let urlString = "\(CM_NetworkManager.shared.initialPath)authentication/token/new?api_key=\(CM_NetworkManager.shared.apiKey)"
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let respuestaDiferente = responseData {
                    if let data = try? JSONDecoder().decode(MovieToken.self, from: respuestaDiferente){
                        if let token = data.token {
                            CM_NetworkManager.shared.request_token = token
                            CM_NetworkManager.shared.userName = name
                            self.fetchUserAndPassword(name: name, password: password)
                        }
                    }
                }
                if let respuestaError = responseError {
                    self.presenter?.responseError(error: "\(respuestaError)")
                    return
                }
            }
            task.resume()
        }
    }
    
    func fetchUserAndPassword(name: String, password: String) {
        let urlString = "\(CM_NetworkManager.shared.initialPath)authentication/token/validate_with_login?api_key=\(CM_NetworkManager.shared.apiKey)"
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            let body: [String: String] = [
                "username": name,
                "password": password,
                "request_token": CM_NetworkManager.shared.request_token
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                self.presenter?.responseError(error: "Failed to create JSON body")
                return
            }
            
            urlRequest.httpBody = httpBody
            
            let task =  URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let respuestaDiferente = responseData {
                    if let data = try? JSONDecoder().decode(MovieLogin.self, from: respuestaDiferente){
                        if let success = data.success {
                            DispatchQueue.main.async {
                                if success == true {
                                    self.authenticateToken()
                                }
                                else {
                                    if let error = data.status_message {
                                        self.presenter?.responseError(error: error)
                                    }
                                }
                            }
                        }
                    }
                }
                if let respuestaError = responseError {
                    DispatchQueue.main.async {
                        self.presenter?.responseError(error: "\(respuestaError)")
                    }
                    return
                }
            }
            task.resume()
        }
    }
    
    func authenticateToken() {
        let urlString = "\(CM_NetworkManager.shared.initialPath)authentication/session/new?api_key=\(CM_NetworkManager.shared.apiKey)"
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            let body: [String: String] = [
                "request_token": CM_NetworkManager.shared.request_token
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                self.presenter?.responseError(error: "Failed to create JSON body")
                return
            }
            
            urlRequest.httpBody = httpBody
            
            let task =  URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let respuestaDiferente = responseData {
                    if let data = try? JSONDecoder().decode(MovieSession.self, from: respuestaDiferente){
                        if let success = data.success {
                            if success{
                                DispatchQueue.main.async {
                                    CM_NetworkManager.shared.sesionID = data.session_id ?? ""
                                    self.presenter?.responseUserAndPassword()
                                }
                            }else{
                                self.presenter?.responseError(error: "No se pudo autenticar la sesion del token: \(CM_NetworkManager.shared.sesionID)")
                            }
                        }
                        else {
                            self.presenter?.responseError(error: "No se pudo autenticar la sesion del token: \(CM_NetworkManager.shared.sesionID)")
                        }
                    }
                }
                if let respuestaError = responseError {
                    DispatchQueue.main.async {
                        self.presenter?.responseError(error: "\(respuestaError)")
                    }
                    return
                }
            }
            task.resume()
        }
    }
}

