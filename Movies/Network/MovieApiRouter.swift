//
//  MovieApiRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 03/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Alamofire
import Foundation

enum MovieApiRouter: ApiRouter {
    case discover(page: Int)
    case search(movie: String, page: Int)

    var baseUrl: URL {
        return Constants.API.baseURL
    }

    var method: HTTPMethod { return .get }

    var path: String {
        switch self {
        case .discover:
            return Constants.API.discover
        case .search:
            return Constants.API.search
        }
    }

    var parameters: RequestParams {
        switch self {
        case let .discover(page):
            return .url([Constants.API.apiKeyName: Constants.API.apiKey, "page": page])
        case let .search(movie, page):
            return .url([Constants.API.apiKeyName: Constants.API.apiKey, "query": movie, "page": page])
        }
    }
}
