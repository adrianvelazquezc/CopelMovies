//
//  CM_MoviesInteractor.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

class CM_MoviesInteractor{
    var presenter: CM_MoviesPresenterProtocol?
}

extension CM_MoviesInteractor: CM_MoviesInteractorProtocol {
    func fetchFavoriteListMovies() {
        let urlString = "\(CM_NetworkManager.shared.initialPath)account/\(CM_NetworkManager.shared.userName)/favorite/movies"
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: CM_NetworkManager.shared.apiKey),
                    URLQueryItem(name: "session_id", value: CM_NetworkManager.shared.sesionID),
                    URLQueryItem(name: "sort_by", value: "created_at.asc"),
                    URLQueryItem(name: "page", value: "1"),
            ]
            
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                    if let respuestaDiferente = responseData {
                        if let data = try? JSONDecoder().decode(MoviesListResponse.self, from: respuestaDiferente){
                            if let movieList = data.results {
                                DispatchQueue.main.async {
                                    self.presenter?.responseFavoriteList(list: movieList)
                                }
                            }
                        }
                    }
                    if let respuestaError = responseError {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: "\(respuestaError)", step: .getFavoritesMovies)
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
    
    func fetchMovieList(gender: MoviesCategories) {
        let urlString = "\(CM_NetworkManager.shared.initialPath)movie/\(gender)"
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: CM_NetworkManager.shared.apiKey)
            ]
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                    if let respuestaDiferente = responseData {
                        if let data = try? JSONDecoder().decode(MoviesListResponse.self, from: respuestaDiferente){
                            if let movieList = data.results {
                                DispatchQueue.main.async {
                                    self.presenter?.responseMovieList(movieList)
                                }
                            }
                        }
                    }
                    if let respuestaError = responseError {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: "\(respuestaError)", step: .getmoviesList)
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
    
    func postDeleteSession() {
        let urlString = "\(CM_NetworkManager.shared.initialPath)authentication/session"
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: CM_NetworkManager.shared.apiKey),
                    URLQueryItem(name: "session_id", value: CM_NetworkManager.shared.sesionID),
            ]
            
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "Delete"
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                    if let respuestaDiferente = responseData {
                        if let data = try? JSONDecoder().decode(CloseSession.self, from: respuestaDiferente){
                            if let deleted = data.success {
                                DispatchQueue.main.async {
                                    if deleted{
                                        self.presenter?.responseDeletedSession()
                                    } else {
                                        self.presenter?.responseError(error: "Error al eliminar la sesion", step: .deleteSession)
                                    }
                                }
                            }
                        }
                    }
                    if let respuestaError = responseError {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: "\(respuestaError)", step: .deleteSession)
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
    
    func fetchFavoriteMovie(isFavorite: Bool, movieId: Int) {
        let urlString = "\(CM_NetworkManager.shared.initialPath)account/\(CM_NetworkManager.shared.userName)/favorite?api_key=\(CM_NetworkManager.shared.apiKey)&session_id=\(CM_NetworkManager.shared.sesionID)"
        
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            let body: [String: Any] = [
                "media_type": "movie",
                "media_id": movieId,
                "favorite": isFavorite
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                self.presenter?.responseError(error: "Failed to create JSON body", step: .updateFavoriteMovie)
                return
            }
            
            urlRequest.httpBody = httpBody
            
            let task =  URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let respuestaDiferente = responseData {
                    if let data = try? JSONDecoder().decode(MovieLogin.self, from: respuestaDiferente){
                        if let success = data.success {
                            DispatchQueue.main.async {
                                if success == true {
                                    self.presenter?.responseFavoriteMovie()
                                }
                                else {
                                    if let error = data.status_message {
                                        self.presenter?.responseError(error: error, step: .updateFavoriteMovie)
                                    }
                                }
                            }
                        }
                    }
                }
                if let respuestaError = responseError {
                    DispatchQueue.main.async {
                        self.presenter?.responseError(error: "\(respuestaError)", step: .updateFavoriteMovie)
                    }
                    return
                }
            }
            task.resume()
        }
    }
    
    func fetchFavoritesWithPresent() {
        let urlString = "\(CM_NetworkManager.shared.initialPath)account/\(CM_NetworkManager.shared.userName)/favorite/movies"
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: CM_NetworkManager.shared.apiKey),
                    URLQueryItem(name: "session_id", value: CM_NetworkManager.shared.sesionID),
                    URLQueryItem(name: "sort_by", value: "created_at.asc"),
                    URLQueryItem(name: "page", value: "1"),
            ]
            
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                    if let respuestaDiferente = responseData {
                        if let data = try? JSONDecoder().decode(MoviesListResponse.self, from: respuestaDiferente){
                            if let movieList = data.results {
                                DispatchQueue.main.async {
                                    self.presenter?.responseFavoritesWithPresent(list: movieList)
                                }
                            }
                        }
                    }
                    if let respuestaError = responseError {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: "\(respuestaError)", step: .getFavoritesWithPresent)
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
}
