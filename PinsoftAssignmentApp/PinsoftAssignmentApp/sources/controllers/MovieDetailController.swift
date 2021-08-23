//
//  MovieDetailController.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import Firebase

final class MovieDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let movieDetailHeaderCellId = "movieDetailHeaderCellId"
    private let overviewCellId = "overviewCellId"
    private let informingCellId = "informingCellId"
    
    private let viewModel: MovieDetailViewModel
    
    private let imdbId: String
    private let name: String
    
    init(
        imdbId: String,
        name: String
    ) {
        self.imdbId = imdbId
        self.name = name
        
        viewModel = MovieDetailViewModel()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = .zero
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = Color.backgroundDefault.value
        collectionView.backgroundColor = Color.backgroundDefault.value

        collectionView.contentInset = .init(top: Sizing.space20pt, left: Sizing.space16pt, bottom: Sizing.space20pt, right: Sizing.space16pt)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.register(MovieDetailHeaderCell.self, forCellWithReuseIdentifier: movieDetailHeaderCellId)
        collectionView.register(MovieDetailOverviewCell.self, forCellWithReuseIdentifier: overviewCellId)
        collectionView.register(InformingCell.self, forCellWithReuseIdentifier: informingCellId)
        
        viewModel.delegate = self
        
        viewModel.fetchData(imdbId: imdbId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MovieDetailController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.state {
        case .data:
            return 2
            
        case .emptyOrError,
             .loading:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.state {
        case .data:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieDetailHeaderCellId, for: indexPath) as! MovieDetailHeaderCell
                
                if let data = viewModel.data {
                    cell.setData(
                        imageUrl: data.imageUrl,
                        name: data.name
                    )
                }
                
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: overviewCellId, for: indexPath) as! MovieDetailOverviewCell
                
                if let data = viewModel.data {
                    cell.setData(
                        properties: data.properties
                    )
                }
                
                return cell
                
            default:
                return UICollectionViewCell()
            }
            
        case .emptyOrError,
             .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: informingCellId, for: indexPath) as! InformingCell
            
            cell.setState(viewModel.state)
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieDetailController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.state {
        case .data:
            switch indexPath.item {
            case 0:
                return .init(
                    width: Sizing.oneColumn,
                    height: Sizing.posterViewDetail.height
                )
                
            case 1:
                let estimatedSize = EstimatedSizeUtility<MovieDetailOverviewCell>.height(
                    width: Sizing.oneColumn
                ) { (cell) in
                    if let data = self.viewModel.data {
                        cell.setData(
                            properties: data.properties
                        )
                    }
                }
                
                return estimatedSize
                
            default:
                return .zero
            }
            
        case .emptyOrError,
             .loading:
            return .init(
                width: Sizing.oneColumn,
                height: 300
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.state {
        case .data:
            return Sizing.space20pt
            
        case .emptyOrError,
             .loading:
            return .zero
        }
    }
}

// MARK: - MovieDetailViewModelDelegate

extension MovieDetailController: MovieDetailViewModelDelegate {
    func getData(error: ErrorModel?) {
        guard error == nil else {
            print(error?.message ?? "")
            
            AlertUtility.present(
                title: error?.title ?? "API Error",
                message: error?.message ?? "An error has occurred.",
                delegate: self
            )
            
            collectionView.reloadData()
            
            return
        }
        
        Analytics.logEvent(
            "MovieDetail",
            parameters: viewModel.data?.logs
        )
        
        collectionView.reloadData()
    }
}
