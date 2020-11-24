//
//  Movie+Mock.swift
//  Movies
//
//  Created by Daniel Daverio on 04/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
@testable import Movies

extension Movies {
    static func buildDiscoveryMocks() -> Movies? {
        return buildMoviesFromFile(name: "discover_movies")
    }
    
    static func buildSearchMocks() -> Movies? {
        return buildMoviesFromFile(name: "search_movies")
    }
    
    private static func buildMoviesFromFile(name: String) -> Movies? {
        guard let data = readFileFromBundle(name: name),
            let movies = try? JSONDecoder().decode(Movies.self, from: data) else {
            print("Unable to read from file")
            return nil
        }
        return movies
    }
}

func readFileFromBundle(name: String) -> Data? {
    @objc class TestClass: NSObject {}

    let bundle = Bundle(for: TestClass.self)
    guard let path = bundle.path(forResource: name, ofType: "json") else { return nil }
    return (try? Data(contentsOf: URL(fileURLWithPath: path)))
}
