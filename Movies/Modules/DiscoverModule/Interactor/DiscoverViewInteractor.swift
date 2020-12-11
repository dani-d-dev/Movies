//
//  DiscoverViewInteractor.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import RxSwift

final class DiscoverViewInteractor: DiscoverModuleInteractorInputProtocol {
    internal weak var presenter: DiscoverModuleInteractorOutputProtocol?
    internal var service: ApiClient?
    private var disposeBag: DisposeBag

    // Pagination related
    internal var pagination: PaginationInfo = PaginationInfo()
    internal var items: [Movie] = []

    init(
        presenter: DiscoverModuleInteractorOutputProtocol? = nil,
        service: ApiClient = MovieApiClient()
    ) {
        self.presenter = presenter
        self.service = service
        disposeBag = DisposeBag()
    }

    func fetchData(page: Int) {
        service?.discover(page: page).subscribe(onSuccess: { [weak self] result in
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

    func loadNextPageIfNeeded() {
        guard !pagination.hasReachedEnd else { return }
        pagination.currentPage += 1
        fetchData(page: pagination.currentPage)
    }
    
    private func reset() {
        pagination.reset()
        items = []
    }
}
