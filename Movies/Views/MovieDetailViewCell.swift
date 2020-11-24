//
//  MovieHeaderViewCell.swift
//  Movies
//
//  Created by Daniel Daverio on 13/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import Kingfisher
import SnapKit
import UIKit

class MovieDetailViewCell: UICollectionViewCell {
    enum Constants {
        static let posterImageMaxWidthPercentage = 0.55
        static let posterImageHeightScale = 1.5
    }

    private let posterImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "movie_placeholder_icon"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()

    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()

    private let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
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
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.edges.width.equalTo(UIScreen.main.bounds.size)
        }

        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(textLabel)

        posterImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Constants.posterImageMaxWidthPercentage)
            $0.height.equalTo(posterImage.snp.width).multipliedBy(Constants.posterImageHeightScale)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(15)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(15)
        }

        textLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}

extension MovieDetailViewCell: ConfigurableCell {
    func configure(model: MovieViewModel) {
        titleLabel.text = model.model.originalTitle
        subtitleLabel.text = model.model.releaseDate ?? "No info"
        textLabel.text = model.model.overview

        guard let path = model.model.posterPath,
            let url = URL(string: path) else {
                posterImage.image = UIImage(named: "movie_placeholder_icon")
                return
        }

        posterImage.kf.setImage(with: url)
    }
}
