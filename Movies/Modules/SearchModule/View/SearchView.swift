//
//  SecondView.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import SnapKit
import UIKit

final class SearchView: UIViewController {
    
    // MARK: - Properties

    internal var presenter: SearchModulePresenterProtocol?

    private lazy var collectionViewDataSource = { CollectionViewDataSource() }()
    private lazy var collectionViewLayout = { ColumnFlowLayout() }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.register(cellType: MovieViewCell.self)
        view.contentInsetAdjustmentBehavior = .always
        view.dataSource = collectionViewDataSource
        view.delegate = collectionViewDataSource
        view.backgroundColor = .black
        return view
    }()

    private lazy var searchController: SearchController = {
        SearchController(
            autocapitalizationType: .none,
            obscuresBackgroundDuringPresentation: true
        )
    }()

    private lazy var placeholderView: PlaceholderView = { PlaceholderView() }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        view.hidesWhenStopped = true
        return view
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
        setupIndicatorView()
        presenter?.viewDidLoad()
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isTranslucent = false
    }

    private func setupSearchBar() {
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        searchController.didTapSearchButton = { [weak self] text in
            guard !text.isEmpty else { return }
            self?.presenter?.search(movie: text)
        }

        searchController.didTapCancelButton = { [weak self] in
            self?.presenter?.cancel()
        }
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }

        collectionViewDataSource.selectionClosure = { [weak self] item, _ in
            guard let itm = item as? MovieViewModel else { return }
            self?.presenter?.didSelectItem(item: itm)
        }

        collectionViewDataSource.didScrollClosure = { [weak self] in
            guard let text = self?.searchController.searchBar.text, !text.isEmpty else { return }
            self?.presenter?.search(movie: text)
        }
    }

    private func setupIndicatorView() {
        activityIndicator.removeFromSuperview()
        view.insertSubview(activityIndicator, at: view.subviews.count)
        activityIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension SearchView: SearchModuleViewProtocol {
    func showRetrievedData(movies: [MovieViewModel]) {
        collectionViewDataSource.items = movies.map {
            CellConfiguratorHolder<MovieViewCell, MovieViewModel>.init(model: $0)
        }
        collectionView.reloadData()
    }

    func showNoContent() {
        collectionViewDataSource.items = [CellConfigurator]()
        collectionView.reloadData()
    }

    func showError(error _: Error?) {
        // TODO: Show error cell warning
    }

    func showPlaceholderView() {
        placeholderView.removeFromSuperview()
        view.insertSubview(placeholderView, belowSubview: activityIndicator)
        placeholderView.setupConstraints()
    }

    func hidePlaceholderView() {
        placeholderView.removeFromSuperview()
    }

    func showLoadingView() {
        activityIndicator.startAnimating()
    }

    func hideLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
