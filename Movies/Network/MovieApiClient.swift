//
//  MovieApiClient.swift
//  Movies
//
//  Created by Daniel Daverio on 28/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Alamofire
import RxSwift

struct MovieApiClient: ApiClient {
    func discover(page: Int?) -> Single<Movies> {
        return Single<Movies>.create { single in
            AF.request(MovieApiRouter.discover(page: page ?? 1)).responseDecodable { (response: AFDataResponse<Movies>) in
                switch response.result {
                case let .success(movies):
                    single(.success(movies))
                case let .failure(error):
                    single(.error(error))
                }
            }

            return Disposables.create {}
        }
    }

    func search(movie: String, page: Int?) -> Single<Movies> {
        return Single<Movies>.create { single in
            AF.request(MovieApiRouter.search(movie: movie, page: page ?? 1)).responseDecodable { (response: AFDataResponse<Movies>) in
                switch response.result {
                case let .success(movies):
                    single(.success(movies))
                case let .failure(error):
                    single(.error(error))
                }
            }

            return Disposables.create {}
        }
    }
}
