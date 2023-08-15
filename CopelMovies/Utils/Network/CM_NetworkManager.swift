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

}

