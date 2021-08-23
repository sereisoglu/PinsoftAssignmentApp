//
//  MovieExtendedModel.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

struct MovieExtendedModel: Decodable {
    private(set) var imdbId: String?
    private(set) var imageUrl: String?
    private(set) var name: String
    private(set) var releasedDate: String
    
    private(set) var properties = [(key: String, value: String)]()
    private(set) var logs = [String : Any]()
    
    enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case imageUrl = "Poster"
        case name = "Title"
        case releasedDate = "Released"
        case rated = "Rated"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case imdbRating = "imdbRating"
        case imdbVoteCount = "imdbVotes"
        case plot = "Plot"
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
        
        logs["imdbId"] = imdbId
        logs["imageUrl"] = imageUrl
        
        [
            (key: "name", value: name),
            (key: "released date", value: releasedDate),
            (key: "rated", value: try values.decode(String?.self, forKey: .rated)),
            (key: "runtime", value: try values.decode(String?.self, forKey: .runtime)),
            (key: "genre", value: try values.decode(String?.self, forKey: .genre)),
            (key: "director", value: try values.decode(String?.self, forKey: .director)),
            (key: "writer", value: try values.decode(String?.self, forKey: .writer)),
            (key: "actors", value: try values.decode(String?.self, forKey: .actors)),
            (key: "language", value: try values.decode(String?.self, forKey: .language)),
            (key: "country", value: try values.decode(String?.self, forKey: .country)),
            (key: "awards", value: try values.decode(String?.self, forKey: .awards)),
            (key: "box office", value: try values.decode(String?.self, forKey: .boxOffice)),
            (key: "production", value: try values.decode(String?.self, forKey: .production)),
            (key: "imdb rating", value: try values.decode(String?.self, forKey: .imdbRating)),
            (key: "imdb vote count", value: try values.decode(String?.self, forKey: .imdbVoteCount)),
            (key: "plot", value: try values.decode(String?.self, forKey: .plot)),
        ].forEach { (arg0) in
            let (key, value) = arg0
            
            if let value = value {
                properties.append((key: key, value: value))
                logs[key] = value
            }
        }
    }
}
