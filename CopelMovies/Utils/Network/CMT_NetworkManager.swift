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
    
    private init() {}

}

