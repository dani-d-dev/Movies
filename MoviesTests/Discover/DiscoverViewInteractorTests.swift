//
//  DiscoverViewInteractorTests.swift
//  Movies
//
//  Created by Daniel Daverio on 05/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//
@testable import Movies
import XCTest
import Alamofire

class DiscoverViewInteractorTests: XCTestCase {
    var sut: DiscoverViewInteractor?
    var mockInteractorOutput: MockDiscoverModuleInteractorOutput?
    var mockService: MockApiClient?

    override func setUp() {
        super.setUp()
        mockService = MockApiClient()
        mockInteractorOutput = MockDiscoverModuleInteractorOutput()
        sut = DiscoverViewInteractor(presenter: mockInteractorOutput!, service: mockService!)
    }

    override func tearDown() {
        sut = nil
        mockInteractorOutput = nil
        mockService = nil
        super.tearDown()
    }

    func test_fetchDiscovery_noResults_shouldReturnEmptyResponse() {
        mockService?.state = .empty

        sut?.loadNextPageIfNeeded()

        XCTAssertTrue(mockInteractorOutput!.isSuccess)
        XCTAssertEqual(mockInteractorOutput!.movies.count, 0)
    }

    func test_fetchDiscovery_results_shouldReturnSuccessResponse() {
        guard let movies = Movies.buildDiscoveryMocks() else {
            XCTFail("Couldn't generate mocks for movies")
            return
        }

        mockService?.state = .success(result: movies)

        sut?.loadNextPageIfNeeded()

        XCTAssertTrue(mockInteractorOutput!.isSuccess)
        XCTAssertEqual(mockInteractorOutput!.movies.count, movies.results.count)
        XCTAssertEqual(mockInteractorOutput!.movies, movies.results)
    }

    func test_fetchDiscovery_failure_shouldReturnErrorResponse() {
        let someError = AFError.explicitlyCancelled
        mockService?.state = .failure(error: someError)

        sut?.loadNextPageIfNeeded()

        XCTAssertTrue(mockInteractorOutput!.error != nil)
        XCTAssertEqual(mockInteractorOutput!.error?.localizedDescription, someError.localizedDescription)
    }
}
