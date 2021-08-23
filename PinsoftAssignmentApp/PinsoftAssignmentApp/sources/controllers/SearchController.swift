//
//  SearchController.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit

final class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let searchItemCellId = "searchItemCellId"
    private let informingCellId = "informingCellId"
    private let footerCellId = "footerCellId"
    
    private let viewModel: SearchViewModel
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Movies"
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    init() {
        viewModel = SearchViewModel()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = Color.backgroundDefault.value
        collectionView.backgroundColor = Color.backgroundDefault.value

        collectionView.contentInset = .init(top: Sizing.space20pt, left: Sizing.space16pt, bottom: Sizing.space20pt, right: Sizing.space16pt)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.register(SearchItemCell.self, forCellWithReuseIdentifier: searchItemCellId)
        collectionView.register(InformingCell.self, forCellWithReuseIdentifier: informingCellId)
        collectionView.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        
        viewModel.delegate = self
        
        searchController.searchBar.delegate = self
        
        activityIndicatorView.addCenterInSuperview(superview: view)
        
        animating(start: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animating(start: false)
        }
    }
    
    
    private func animating(start: Bool) {
        if start {
            activityIndicatorView.animating = true
            collectionView.alpha = 0
        } else {
            activityIndicatorView.animating = false
            UIView.animate(withDuration: 0.5) { [self] in
                collectionView.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.state {
        case .data:
            return viewModel.data?.items.count ?? 0
            
        case .emptyOrError,
             .loading:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.state {
        case .data:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchItemCellId, for: indexPath) as! SearchItemCell
            
            if let item = viewModel.data?.items[safe: indexPath.item] {
                cell.setData(item: item)
            }
            
            return cell
            
        case .emptyOrError,
             .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: informingCellId, for: indexPath) as! InformingCell
            
            cell.setState(viewModel.state)
            
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel.data?.items[safe: indexPath.item],
              let imdbId = item.imdbId else {
            return
        }
        
        navigationController?.pushViewController(
            MovieDetailController(
                imdbId: imdbId,
                name: item.name
            ),
            animated: true
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.state {
        case .data:
            return .init(
                width: Sizing.posterViewHalf.width,
                height: Sizing.posterViewHalf.height + FontType.body1.value.lineHeight + FontType.body2.value.lineHeight
            )
            
        case .emptyOrError,
             .loading:
            return .init(
                width: Sizing.oneColumn,
                height: 300
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.state {
        case .data:
            if viewModel.data?.items.isNotEmpty ?? false {
                return Sizing.space12pt
            } else {
                return .zero
            }
            
        case .emptyOrError,
             .loading:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.state {
        case .data:
            if viewModel.data?.items.isNotEmpty ?? false {
                return Sizing.space12pt
            } else {
                return .zero
            }
            
        case .emptyOrError,
             .loading:
            return .zero
        }
    }
}

// MARK: - Pagination

extension SearchController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath) as! FooterCell
        
        footer.setData(animating: !(viewModel.data?.isDonePaginating ?? true))
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard viewModel.state == .data,
              viewModel.data?.items.isNotEmpty ?? false,
              !(viewModel.data?.isDonePaginating ?? true) else {
            return .zero
        }
        
        return .init(
            width: Sizing.oneColumn,
            height: Sizing.posterViewHalf.height + FontType.body1.value.lineHeight + FontType.body2.value.lineHeight
        )
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = viewModel.data?.items.count ?? 0
        
        guard viewModel.state == .data,
              count > 0,
              !(viewModel.data?.isPaginating ?? true),
              !(viewModel.data?.isDonePaginating ?? true),
              indexPath.item >= count - 1 else {
            return
        }
        
        viewModel.fetchOtherPage()
    }
}

// MARK: - SearchViewModelDelegate

extension SearchController: SearchViewModelDelegate {
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
        
        collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        viewModel.fetchData(query: text)
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reset()
        
        collectionView.reloadData()
    }
}
