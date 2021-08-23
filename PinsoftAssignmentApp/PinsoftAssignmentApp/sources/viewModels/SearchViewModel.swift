//
//  SearchViewModel.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func getData(error: ErrorModel?)
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    
    private(set) var data: PaginationModel<MovieModel>?
    
    private(set) var state: InformingState = .data
    
    private(set) var query: String = ""
    
    init() {
        reset()
    }
    
    func fetchData(query: String) {
        guard self.query != query else {
            return
        }
        
        self.query = query
        
        state = .loading
        
        APIService.shared.request(
            endpoint: .search(query: query),
            page: 1
        ) { [weak self] (result: Result<PaginationModel<MovieModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.state = .data
                
                self.data = data
                
                self.delegate?.getData(error: nil)
                
            case .failure(let error):
                if error.message == "Movie not found!" {
                    self.state = .emptyOrError(
                        headerText: "No Results",
                        messageText: "for \"\(query)\""
                    )
                } else {
                    self.state = .emptyOrError(
                        headerText: error.title ?? "API Error",
                        messageText: error.message ?? "An error has occurred."
                    )
                }
                
                self.delegate?.getData(error: error)
            }
        }
    }
    
    func fetchOtherPage() {
        let query = self.query
        
        data?.setIsPaginating(isPaginating: true)
        data?.increasePage()
        
        APIService.shared.request(
            endpoint: .search(query: query),
            page: data?.page ?? 2
        ) { [weak self] (result: Result<PaginationModel<MovieModel>?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                if query == self.query {
                    self.data?.appendItems(items: data?.items)
                }
                
            case .failure(let error):
                if error.message != "Movie not found!" {
                    self.state = .emptyOrError(
                        headerText: error.title ?? "API Error",
                        messageText: error.message ?? "An error has occurred."
                    )
                }
                
                self.delegate?.getData(error: error)
                
                return
            }
            
            self.data?.setIsPaginating(isPaginating: false)
            
            self.delegate?.getData(error: nil)
        }
    }
    
    func reset() {
        data = nil
        
        state = .emptyOrError(
            headerText: "Start Searching",
            messageText: "Search all of PAA for movies."
        )
        
        query = ""
    }
}
