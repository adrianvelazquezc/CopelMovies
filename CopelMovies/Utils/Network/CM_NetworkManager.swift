//
//  CM_NetworkManager.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

class CM_NetworkManager {
    static let shared = CM_NetworkManager()
    
    public var apiKey = "e142ca6d5b52024931683472e1abbef2"
    public var userName = ""
    public var request_token = ""
    public var sesionID = ""
    public var initialPath = "https://api.themoviedb.org/3/"
    public var firstURL: String = "https://image.tmdb.org/t/p/w500"
    
    public let textColor =  #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1)
    public let backgroundColor =  #colorLiteral(red: 0.03991495073, green: 0.08235343546, blue: 0.1102337912, alpha: 1)
    
    private init() {}
    
    func deleteFavorite(currentId: Int, completionHandler:@escaping(MovieLogin?,Int?,Error?)->Void){
        let urlString = "\(CM_NetworkManager.shared.initialPath)account/\(CM_NetworkManager.shared.userName)/favorite?api_key=\(CM_NetworkManager.shared.apiKey)&session_id=\(CM_NetworkManager.shared.sesionID)"
        
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            let body: [String: Any] = [
                "media_type": "movie",
                "media_id": currentId,
                "favorite": false
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                completionHandler(nil, nil, "error al convertir el json" as? Error)
                return
            }
            
            urlRequest.httpBody = httpBody
            
            let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let auxResponse = responseCode as? HTTPURLResponse {
                    let _ = auxResponse.statusCode
                }
                guard let respuestaDiferente = responseData else {
                    completionHandler(nil, responseCode.hashValue, responseError)
                    return
                }
                if let json = try? JSONDecoder().decode(MovieLogin.self, from: respuestaDiferente){
                    completionHandler(json,200,nil)
                }
            }
            task.resume()
        }
    }
}

