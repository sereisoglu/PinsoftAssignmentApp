//
//  InformingState.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

enum InformingState: Equatable {
    case data
    case emptyOrError(headerText: String, messageText: String)
    case loading
}
