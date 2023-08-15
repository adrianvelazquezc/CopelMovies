//
//  CM_LoginEntity.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

struct MovieToken: Codable{
    let success: Bool?
    let token: String?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case token = "request_token"
    }
}
struct MovieLogin: Codable{
    let success: Bool?
    let status_message: String?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case status_message = "status_message"
    }
}

struct MovieSession: Codable{
    let success: Bool?
    let session_id: String?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case session_id = "session_id"
    }
}
