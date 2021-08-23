//
//  Collection+Extension.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}

// https://medium.com/flawless-app-stories/say-goodbye-to-index-out-of-range-swift-eca7c4c7b6ca
extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
