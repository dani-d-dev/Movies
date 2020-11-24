//
//  SecondViewInteractor.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewInteractor: SearchModuleInteractorInputProtocol {
    internal weak var presenter: SearchModuleInteractorOutputProtocol?
    internal var service: ApiClient?
    internal var lastSearch: String?
    private var disposeBag: DisposeBag

    // Pagination related
    internal var pagination: PaginationInfo = PaginationInfo()
    internal var items: [Movie] = []

    init(
        presenter: SearchModuleInteractorOutputProtocol? = nil,
        service: ApiClient = MovieApiClient()
    ) {
        self.presenter = presenter
        self.service = service
        disposeBag = DisposeBag()
    }

    func search(movie: String) {
        if pagination.hasReachedEnd, lastSearch == movie { return }

        if lastSearch != movie {
            reset()
        }

        pagination.currentPage = (lastSearch == movie) ? pagination.currentPage + 1 : 1

        fetch(movie: movie, page: pagination.currentPage)
    }

    private func fetch(movie: String, page: Int) {
        lastSearch = movie

        service?.search(movie: movie, page: page).subscribe(onSuccess: { [weak self] result in
            guard !result.results.isEmpty else {
                self?.reset()
                self?.presenter?.dataFetchedEmpty()
                return
            }
            self?.pagination.totalPages = result.totalPages
            self?.items.append(contentsOf: result.results)
            self?.presenter?.dataFetchedSuccess(movies: self?.items ?? [])
        }) { [weak self] err in
            print(err.localizedDescription)
            self?.reset()
            self?.presenter?.dataFetchedFailure(error: err)
        }.disposed(by: disposeBag)
    }

    func cancel() {
        reset()
        presenter?.dataFetchedEmpty()
    }

    private func reset() {
        pagination.reset()
        items = []
        lastSearch = ""
    }
}
