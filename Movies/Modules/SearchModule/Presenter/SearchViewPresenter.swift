//
//  SecondViewPresenter.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

final class SearchViewPresenter: SearchModulePresenterProtocol {
    
    internal weak var view: SearchModuleViewProtocol?
    internal var interactor: SearchModuleInteractorInputProtocol?
    internal var router: SearchModuleRouterProtocol?

    internal init(
        view: SearchModuleViewProtocol? = nil,
        interactor: SearchModuleInteractorInputProtocol? = nil,
        router: SearchModuleRouterProtocol? = nil
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showPlaceholderView()
    }

    func search(movie: String) {
        view?.showLoadingView()
        view?.hidePlaceholderView()
        interactor?.search(movie: movie)
    }
    
    func cancel() {
        interactor?.cancel()
    }
    
    func didSelectItem(item: MovieViewModel?) {
        router?.presentDetailView(movie: item?.model, from: view!)
    }
}

extension SearchViewPresenter: SearchModuleInteractorOutputProtocol {
    func dataFetchedSuccess(movies: [Movie]) {
        view?.hideLoadingView()
        view?.hidePlaceholderView()
        view?.showRetrievedData(movies: movies.map(MovieViewModel.init))
    }

    func dataFetchedEmpty() {
        view?.hideLoadingView()
        view?.showPlaceholderView()
        view?.showNoContent()
    }

    func dataFetchedFailure(error: Error?) {
        print(error ?? "some error")
        view?.hideLoadingView()
        view?.hidePlaceholderView()
        view?.showError(error: error)
    }
}
