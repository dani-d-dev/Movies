//
//  DiscoverViewPresenter.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

final class DiscoverViewPresenter: DiscoverModulePresenterProtocol {
    
    internal weak var view: DiscoverModuleViewProtocol?
    internal var interactor: DiscoverModuleInteractorInputProtocol?
    internal var router: DiscoverModuleRouterProtocol?

    init(
        view: DiscoverModuleViewProtocol? = nil,
        interactor: DiscoverModuleInteractorInputProtocol? = nil,
        router: DiscoverModuleRouterProtocol? = nil
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        view?.showLoadingView()
        interactor?.loadNextPageIfNeeded()
    }
    
    func loadNextPageIfNeeded() {
        view?.showLoadingView()
        interactor?.loadNextPageIfNeeded()
    }

    func didSelectItem(item: MovieViewModel?) {
        router?.presentDetailView(movie: item?.model, from: view!)
    }
}

extension DiscoverViewPresenter: DiscoverModuleInteractorOutputProtocol {
    func dataFetchedSuccess(movies: [Movie]) {
        view?.hideLoadingView()
        view?.showRetrievedData(movies: movies.map(MovieViewModel.init))
    }

    func dataFetchedEmpty() {
        view?.hideLoadingView()
        view?.showNoContent()
    }

    func dataFetchedFailure(error: Error?) {
        print(error ?? "some error")
        view?.hideLoadingView()
        view?.showError(error: error)
    }
}
