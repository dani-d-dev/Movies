//
//  DiscoverView.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import SnapKit
import UIKit

class DiscoverView: UIViewController {
    
    // MARK: - Properties

    internal var presenter: DiscoverModulePresenterProtocol?

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

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        view.hidesWhenStopped = true
        return view
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupIndicatorView()
        presenter?.viewDidLoad()
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        navigationItem.title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.isTranslucent = false
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }

        collectionViewDataSource.selectionClosure = { [weak self] item, _ in
            guard let itm = item as? MovieViewModel else { return }
            self?.presenter?.didSelectItem(item: itm)
        }

        collectionViewDataSource.didScrollClosure = { [weak self] in
            self?.presenter?.loadNextPageIfNeeded()
        }
    }

    private func setupIndicatorView() {
        activityIndicator.removeFromSuperview()
        view.insertSubview(activityIndicator, at: view.subviews.count)
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

extension DiscoverView: DiscoverModuleViewProtocol {
    func showRetrievedData(movies: [MovieViewModel]) {
        // Map view models into cell configurators
        collectionViewDataSource.items = movies.map {
            CellConfiguratorHolder<MovieViewCell, MovieViewModel>.init(model: $0)
        }
        collectionView.reloadData()
    }

    func showNoContent() {
        // TODO: Show placeholder empty cell
        collectionViewDataSource.items = [CellConfigurator]()
        collectionView.reloadData()
    }

    func showError(error _: Error?) {
        // TODO: Show error cell warning
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
