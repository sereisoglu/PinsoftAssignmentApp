//
//  Text.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

struct Text {
    enum `Type` {
        case `default`
        case underlined
        case medium
        case bold
    }
    
    var type: Type = .default
    var string: String
}
