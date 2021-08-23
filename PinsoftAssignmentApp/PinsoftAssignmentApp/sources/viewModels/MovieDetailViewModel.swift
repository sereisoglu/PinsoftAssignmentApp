//
//  MovieDetailViewModel.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import Foundation

protocol MovieDetailViewModelDelegate: AnyObject {
    func getData(error: ErrorModel?)
}

final class MovieDetailViewModel {
    weak var delegate: MovieDetailViewModelDelegate?
    
    private(set) var data: MovieExtendedModel?
    
    private(set) var state: InformingState = .data
    
    func fetchData(imdbId: String) {
        state = .loading
        
        APIService.shared.request(
            endpoint: .movieDetail(imdbId: imdbId)
        ) { [weak self] (result: Result<MovieExtendedModel?, ErrorModel>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.state = .data
                
                self.data = data
                
                self.delegate?.getData(error: nil)
                
            case .failure(let error):
                self.state = .emptyOrError(
                    headerText: error.title ?? "API Error",
                    messageText: error.message ?? "An error has occurred."
                )
                
                self.delegate?.getData(error: error)
            }
        }
    }
}
