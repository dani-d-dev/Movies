//
//  MovieViewCell.swift
//  Movies
//
//  Created by Daniel Daverio on 11/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Kingfisher
import UIKit

class MovieViewCell: UICollectionViewCell {
    private let movieImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "movie_placeholder_icon"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        contentView.addSubview(movieImage)
        movieImage.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension MovieViewCell: ConfigurableCell {
    func configure(model: MovieViewModel) {
        guard let path = model.model.posterPath,
            let url = URL(string: path) else { return }

        movieImage.kf.setImage(with: url)
    }
}
