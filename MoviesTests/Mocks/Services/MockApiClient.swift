//
//  MockApiClient.swift
//  Movies
//
//  Created by Daniel Daverio on 04/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import RxSwift
@testable import Movies

class MockApiClient: ApiClient {
    enum State {
        case empty
        case success(result: Movies)
        case failure(error: Error)
    }

    var state: State = .empty
    private let emptyContent = Movies(page: 0, results: [], totalResults: 0, totalPages: 0)
    
    var searchTerm: String = ""

    func discover(page: Int? = 1) -> Single<Movies> {
        return commonResponse()
    }
    
    func search(movie: String, page: Int? = 1) -> Single<Movies> {
        searchTerm = movie
        return commonResponse()
    }

    private func commonResponse() -> Single<Movies> {
        switch state {
        case .empty:
            return .just(emptyContent)
        case let .failure(error):
            return .error(error)
        case let .success(movies):
            return .just(movies)
        }
    }
}
