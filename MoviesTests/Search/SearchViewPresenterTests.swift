//
//  SearchViewPresenterTests.swift
//  Movies
//
//  Created by Daniel Daverio on 20/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Alamofire
@testable import Movies
import XCTest

class SearchViewPresenterTests: XCTestCase {
    var sut: SearchViewPresenter?
    var mockView: MockSearchModuleView?
    var mockInteractor: MockSearchModuleInteractor?
    var mockRouter: MockSearchModuleRouter?
    var mockService: MockApiClient?

    override func setUp() {
        sut = SearchViewPresenter()
        mockView = MockSearchModuleView()
        mockInteractor = MockSearchModuleInteractor()
        mockRouter = MockSearchModuleRouter()
        mockService = MockApiClient()
        mockInteractor?.presenter = sut
        mockInteractor?.service = mockService
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
        mockView?.presenter = sut
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        mockService = nil

        super.tearDown()
    }

    // MARK: - Placeholder views

    func test_onViewDidLoad_showsPlaceholderView() {
        sut?.viewDidLoad()

        XCTAssertTrue(mockView!.showPlaceholder)
        XCTAssertFalse(mockView!.hidePlaceholder)
    }

    func test_afterSearchMovie_onEmptyResponse_showsPlaceholderView() {
        mockService?.state = .empty
        mockInteractor?.isLoading = true

        sut?.search(movie: "some")

        XCTAssertTrue(mockView!.showPlaceholder)
        XCTAssertFalse(mockView!.hidePlaceholder)
    }

    func test_beforeSearchingMovie_hidesPlaceholderView() {
        mockInteractor?.isLoading = false

        sut?.search(movie: "")

        XCTAssertTrue(mockView!.hidePlaceholder)
        XCTAssertFalse(mockView!.showPlaceholder)
    }

    func test_afterSearchMovie_onSuccessResponse_hidesPlaceholderView() {
        guard let movies = Movies.buildSearchMocks() else {
            XCTFail("Couldn't generate mocks for movies")
            return
        }

        mockService?.state = .success(result: movies)
        mockInteractor?.isLoading = true

        sut?.search(movie: "some")

        XCTAssertTrue(mockView!.hidePlaceholder)
        XCTAssertFalse(mockView!.showPlaceholder)
    }

    // MARK: - Loading views

    func test_beforeFetchingData_showsLoadingView() {
        mockInteractor?.isLoading = false

        sut?.search(movie: "some")

        XCTAssertTrue(mockView!.startLoading)
        XCTAssertFalse(mockView!.stopsLoading)
    }

    func test_afterFetchingData_hidesLoadingView() {
        mockInteractor?.isLoading = true

        sut?.search(movie: "some")

        XCTAssertTrue(mockView!.stopsLoading)
        XCTAssertFalse(mockView!.startLoading)
    }

    // MARK: - Server responses

    func test_whenFetchingData_onSuccessResponse_getViewModels() {
        mockService?.state = .success(result: Movies.buildSearchMocks()!)
        mockInteractor?.isLoading = true

        sut?.search(movie: "some")

        switch mockView?.viewState {
        case let .showRetrievedData(movies):
            XCTAssertTrue(movies.count > 0)
        default:
            XCTFail("Wrong state, needs to be fixed!")
        }
    }

    func test_whenFetchingData_onEmptyResponse_showsNoContentView() {
        mockService?.state = .empty
        mockInteractor?.isLoading = true

        sut?.search(movie: "some")

        if case MockSearchModuleView.State.showNoContent = mockView!.viewState {
            return
        }
        XCTFail("Wrong state, needs to be fixed!")
    }

    func test_whenFetchingData_onFailureResponse_showsErrorView() {
        let someError = AFError.explicitlyCancelled
        mockService?.state = .failure(error: someError)
        mockInteractor?.isLoading = true

        sut?.search(movie: "some")

        switch mockView?.viewState {
        case let .showError(error):
            XCTAssertEqual(someError.localizedDescription, error?.localizedDescription)
        default:
            XCTFail("Wrong state, needs to be fixed!")
        }
    }
}
