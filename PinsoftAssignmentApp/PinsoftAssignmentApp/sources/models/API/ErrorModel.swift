//
//  ErrorModel.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

struct ErrorModel: Decodable, Error {
    var title: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "Error"
    }
}
