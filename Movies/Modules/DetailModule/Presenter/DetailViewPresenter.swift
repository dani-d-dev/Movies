//
//  DetailViewPresenter.swift
//  Movies
//
//  Created by Daniel Daverio on 12/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

class DetailViewPresenter: DetailModulePresenterProtocol {
    internal weak var view: DetailModuleViewProtocol?
    internal var interactor: DetailModuleInteractorProtocol?
    internal var router: DetailModuleRouterProtocol?

    init(
        view: DetailModuleViewProtocol? = nil,
        interactor: DetailModuleInteractorProtocol? = nil,
        router: DetailModuleRouterProtocol? = nil
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func loadMovieDetail() {
        guard let movie = interactor?.item else {
            // TODO: call show error in view
            return
        }
        view?.showDetail(item: MovieViewModel(model: movie))
    }
}
