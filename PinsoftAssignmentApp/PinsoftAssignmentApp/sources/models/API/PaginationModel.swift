//
//  PaginationModel.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

struct PaginationModel<T: Decodable>: Decodable {
    private(set) var itemCount: Int = 0
    private(set) var items = [T]()
    
    private(set) var page: Int = 1
    var pageCount: Int {
        get {
            return Int(ceil(Double(itemCount) / Double(APIService.shared.API_PAGE_LIMIT)))
        }
    }
    
    private(set) var isPaginating = false
    private(set) var isDonePaginating = false
    
    enum CodingKeys: String, CodingKey {
        case itemCount = "totalResults"
        case items = "Search"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let tempItemCount = try values.decode(String?.self, forKey: .itemCount)
        itemCount = Int(tempItemCount ?? "0") ?? 0
        
        items = try values.decode([T]?.self, forKey: .items) ?? []
    }
    
    mutating func increasePage() {
        page += 1
    }
    
    mutating func setIsPaginating(isPaginating: Bool) {
        self.isPaginating = isPaginating
    }
    
    mutating func appendItems(items: [T]?) {
        guard let items = items,
              items.isNotEmpty else {
            isDonePaginating = true
            
            return
        }
        
        if pageCount == page {
            isDonePaginating = true
        }
        
        self.items.append(contentsOf: items)
    }
}
