//
//  CM_DetailsEntity.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import Foundation

struct MovieDetails: Codable {
    var id: Int?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var averageVote: Float?
    var countVote: Int?
    var backdropPath: String?
    var homepage: String?
    var video: Bool?
    var voteCount: Int?
    
    var genres: [Genre]?
    struct Genre: Codable {
        var name: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
        }
    }
    
    var productionCompanies: [ProductionCompany]?
    struct ProductionCompany: Codable {
        var name: String?
        var logoPath: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case logoPath = "logo_path"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case averageVote = "vote_average"
        case countVote = "vote_count"
        case genres = "genres"
        case productionCompanies = "production_companies"
    }
}

public struct CloseSession: Codable{
    let success: Bool?
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
    }
}
