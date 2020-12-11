//
//  DetailViewInteractor.swift
//  Movies
//
//  Created by Daniel Daverio on 12/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

final class DetailViewInteractor: DetailModuleInteractorProtocol {
    internal var item: Movie?

    init(item: Movie?) {
        self.item = item
    }
}
