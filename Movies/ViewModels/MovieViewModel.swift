//
//  MovieViewModel.swift
//  Movies
//
//  Created by Daniel Daverio on 04/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype ModelType: Decodable
    init(model: ModelType)
}

struct MovieViewModel: ViewModel {
    let model: Movie

    init(model: Movie) {
        self.model = model
    }
}
