//
//  MockDiscoverModuleInteractor.swift
//  Movies
//
//  Created by Daniel Daverio on 05/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import RxSwift
@testable import Movies

class MockDiscoverModuleInteractor: DiscoverModuleInteractorInputProtocol {
    var presenter: DiscoverModuleInteractorOutputProtocol?
    var service: ApiClient?
    var isLoading = false

    internal var pagination: PaginationInfo = PaginationInfo()
    internal var items: [Movie] = []
    private let disposeBag = DisposeBag()

    func loadNextPageIfNeeded() {
        guard !pagination.hasReachedEnd else { return }
        pagination.currentPage += 1
        fetchData(page: pagination.currentPage)
    }

    func fetchData(page: Int) {
        guard isLoading else { return }
        service?.discover(page: page).subscribe(onSuccess: { [weak self] result in
            guard !result.results.isEmpty else {
                self?.presenter?.dataFetchedEmpty()
                return
            }
            self?.presenter?.dataFetchedSuccess(movies: result.results)

        }) { [weak self] err in
            print(err.localizedDescription)
            self?.presenter?.dataFetchedFailure(error: err)
        }.disposed(by: disposeBag)
    }
}
