//
//  MockDiscoverModuleInteractorOutput.swift
//  Movies
//
//  Created by Daniel Daverio on 05/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
@testable import Movies

class MockDiscoverModuleInteractorOutput: DiscoverModuleInteractorOutputProtocol {
    
    var isSuccess = false
    var error: Error?
    private(set) var movies = [Movie]()
    
    func dataFetchedSuccess(movies: [Movie]) {
        self.movies = movies
        isSuccess = true
    }
    
    func dataFetchedEmpty() {
        self.movies = []
        isSuccess = true
    }    
    
    func dataFetchedFailure(error: Error?) {
        self.error = error
    }
}
