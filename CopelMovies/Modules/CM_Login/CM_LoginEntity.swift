//
//  CM_LoginEntity.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

struct PeliculaToken: Codable{
    let success: Bool?
    let token: String?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case token = "request_token"
    }
}
struct PeliculaLogin: Codable{
    let success: Bool?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
    }
}

struct PeliculaSession: Codable{
    let success: Bool?
    let session_id: String?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case session_id = "session_id"
    }
}