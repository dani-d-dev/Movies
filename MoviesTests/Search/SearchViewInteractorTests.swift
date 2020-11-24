//
//  SearchViewInteractorTests.swift
//  Movies
//
//  Created by Daniel Daverio on 20/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Alamofire
@testable import Movies
import XCTest

class SearchViewInteractorTests: XCTestCase {
    var sut: SearchViewInteractor?
    var mockInteractorOutput: MockSearchModuleInteractorOutput?
    var mockService: MockApiClient?

    override func setUp() {
        super.setUp()
        mockInteractorOutput = MockSearchModuleInteractorOutput()
        mockService = MockApiClient()
        sut = SearchViewInteractor(presenter: mockInteractorOutput!, service: mockService!)
    }

    override func tearDown() {
        sut = nil
        mockInteractorOutput = nil
        mockService = nil
        super.tearDown()
    }

    func test_searchTerm_shouldMatchArgument() {
        let movie = "Logan"
        sut?.search(movie: movie)
        XCTAssertEqual(movie, mockService?.searchTerm)
    }

    func test_matchingSearchTerm_shouldReturnSuccessResponse() {
        guard let movies = Movies.buildSearchMocks() else {
            XCTFail("Couldn't generate mocks for movies")
            return
        }

        mockService?.state = .success(result: movies)

        let movie = "Logan"
        sut?.search(movie: movie)

        XCTAssertTrue(mockInteractorOutput!.isSuccess)
        XCTAssertEqual(mockInteractorOutput!.movies.count, movies.results.count)
        XCTAssertEqual(mockInteractorOutput!.movies, movies.results)
    }

    func test_noMatchingSearchTerm_shouldReturnEmptyResponse() {
        mockService?.state = .empty
        sut?.search(movie: "Logan")

        XCTAssertTrue(mockInteractorOutput!.isSuccess)
        XCTAssertEqual(mockInteractorOutput!.movies.count, 0)
    }

    func test_invalidSearchTerm_shouldReturnErrorResponse() {
        let someError = AFError.explicitlyCancelled
        mockService?.state = .failure(error: someError)

        sut?.search(movie: "")

        XCTAssertTrue(mockInteractorOutput!.error != nil)
        XCTAssertEqual(mockInteractorOutput!.error?.localizedDescription, someError.localizedDescription)
    }
}
