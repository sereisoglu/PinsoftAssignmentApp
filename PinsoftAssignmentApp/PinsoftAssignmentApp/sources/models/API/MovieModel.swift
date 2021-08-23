//
//  MovieModel.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

typealias MovieModels = [MovieModel]

struct MovieModel: Decodable {
    var imdbId: String?
    var imageUrl: String?
    var name: String
    var releasedDate: String
    
    enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case imageUrl = "Poster"
        case name = "Title"
        case releasedDate = "Year"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        imdbId = try values.decode(String?.self, forKey: .imdbId)
        imageUrl = try values.decode(String?.self, forKey: .imageUrl)
        
        if imageUrl == "N/A" {
            imageUrl = nil
        }
        
        name = try values.decode(String?.self, forKey: .name) ?? "No name"
        releasedDate = try values.decode(String?.self, forKey: .releasedDate) ?? "To be announced"
    }
}
