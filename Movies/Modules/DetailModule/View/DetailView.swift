//
//  DetailView.swift
//  Movies
//
//  Created by Daniel Daverio on 12/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import SnapKit
import UIKit

class DetailView: UIViewController {
    private lazy var collectionViewDataSource = { CollectionViewDataSource() }()

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        layout.sectionInset = UIEdgeInsets.zero
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.register(cellType: MovieDetailViewCell.self)
        view.dataSource = collectionViewDataSource
        view.delegate = collectionViewDataSource
        return view
    }()

    var presenter: DetailModulePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.loadMovieDetail()
    }

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension DetailView: DetailModuleViewProtocol {
    func showDetail(item: MovieViewModel) {
        let configCell = CellConfiguratorHolder<MovieDetailViewCell, MovieViewModel>.init(model: item)
        collectionViewDataSource.items = [configCell]
        collectionView.reloadData()
    }

    func showDetailError() {
        // TODO:
    }
}
