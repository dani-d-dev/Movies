//
//  PlaceholderView.swift
//  Movies
//
//  Created by Daniel Daverio on 18/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import SnapKit
import UIKit

final class PlaceholderView: UIView {
    enum Constants {
        static let title = "Go find that movie!"
        static let image = UIImage(named: "movie_placeholder_icon")
    }
    
    // MARK: - Properties

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    // MARK: - Init

    init(
        title: String = Constants.title,
        image: UIImage? = Constants.image,
        frame: CGRect = .zero,
        color: UIColor = .white
    ) {
        titleLabel.text = title
        imageView.image = image
        super.init(frame: frame)
        backgroundColor = color
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    func setupConstraints() {
        snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func setupViews() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
    }
}
