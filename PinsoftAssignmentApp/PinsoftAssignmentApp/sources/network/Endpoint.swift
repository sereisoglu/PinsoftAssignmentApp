//
//  Endpoint.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation
import Alamofire

enum Endpoint: Equatable {
    case search(query: String)
    case movieDetail(imdbId: String)
}

extension Endpoint {
    var urlString: String {
        return "\(APIService.shared.BASE_URL)/\(path)"
    }
    
    var path: String {
        switch self {
        case .search,
             .movieDetail:
            return ""
        }
    }
}

extension Endpoint {
    var httpMethod: HTTPMethod {
        switch self {
        case .search,
             .movieDetail:
            return .get
        }
    }
}

extension Endpoint {
    var headers: HTTPHeaders? {
        switch self {
        case .search,
             .movieDetail:
            return nil
        }
    }
}

extension Endpoint {
    var parameters: Parameters? {
        switch self {
        case .search(let query):
            return [
                "apikey": APIService.shared.API_KEY,
                "v": "1",
                "r": "json",
                "s": query,
                "type": "movie"
            ]
            
        case .movieDetail(let imdbId):
            return [
                "apikey": APIService.shared.API_KEY,
                "v": "1",
                "r": "json",
                "i": imdbId,
                "plot": "full",
                "type": "movie"
            ]
        }
    }
}
