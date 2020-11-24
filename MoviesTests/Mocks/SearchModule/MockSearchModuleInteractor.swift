//
//  MockSearchModuleInteractor.swift
//  Movies
//
//  Created by Daniel Daverio on 20/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import RxSwift
@testable import Movies

class MockSearchModuleInteractor: SearchModuleInteractorInputProtocol {
    var presenter: SearchModuleInteractorOutputProtocol?
    var service: ApiClient?
    var isLoading = false
    var lastSearch: String?

    internal var pagination: PaginationInfo = PaginationInfo()
    internal var items: [Movie] = []
    private let disposeBag = DisposeBag()

    func search(movie: String) {
        guard isLoading else { return }

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
