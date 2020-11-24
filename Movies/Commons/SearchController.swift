//
//  SearchController.swift
//  Movies
//
//  Created by Daniel Daverio on 17/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

final class SearchController: UISearchController {
    typealias DidTapSearchButtonAction = (String) -> Void
    typealias DidTapCancelButtonAction = () -> Void

    internal var didTapSearchButton: DidTapSearchButtonAction?
    internal var didTapCancelButton: DidTapCancelButtonAction?
    private static let placeholderText = "Type a movie..."
    
    init(
        placeholder: String? = SearchController.placeholderText,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        obscuresBackgroundDuringPresentation: Bool = false,
        searchResultController: UIViewController? = nil,
        didTapSearchButton: DidTapSearchButtonAction? = nil,
        didTapCancelButton: DidTapCancelButtonAction? = nil
    ) {
        super.init(searchResultsController: searchResultController)
        
        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = autocapitalizationType
        self.obscuresBackgroundDuringPresentation = obscuresBackgroundDuringPresentation
        searchBar.barStyle = .black
        searchBar.delegate = self
        self.didTapSearchButton = didTapSearchButton
        self.didTapCancelButton = didTapCancelButton
    }

    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didTapSearchButton?(searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        didTapCancelButton?()
    }
}
