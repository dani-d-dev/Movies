//
//  ApiClient.swift
//  Movies
//
//  Created by Daniel Daverio on 04/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiClient {
    func discover(page: Int?) -> Single<Movies>
    func search(movie: String, page: Int?) -> Single<Movies>
}
