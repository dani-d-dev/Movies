//
//  DiscoverViewPresenterTests.swift
//  Movies
//
//  Created by Daniel Daverio on 05/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Alamofire
@testable import Movies
import XCTest

class DiscoverViewPresenterTests: XCTestCase {
    var sut: DiscoverViewPresenter?
    var mockView: MockDiscoverModuleView?
    var mockInteractor: MockDiscoverModuleInteractor?
    var mockRouter: MockDiscoverModuleRouter?
    var mockService: MockApiClient?

    override func setUp() {
        sut = DiscoverViewPresenter()
        mockView = MockDiscoverModuleView()
        mockInteractor = MockDiscoverModuleInteractor()
        mockRouter = MockDiscoverModuleRouter()
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
    
    // MARK: - Loading views

    func test_beforeFetchingData_showsLoadingView() {
        mockInteractor?.isLoading = false

        sut?.viewDidLoad()

        XCTAssertTrue(mockView!.startLoading)
        XCTAssertFalse(mockView!.stopsLoading)
    }

    func test_afterFetchingData_hidesLoadingView() {
        mockInteractor?.isLoading = true

        sut?.viewDidLoad()

        XCTAssertTrue(mockView!.stopsLoading)
        XCTAssertFalse(mockView!.startLoading)
    }
    
    // MARK: - Server responses

    func test_whenFetchingData_onSuccessResponse_getViewModels() {
        mockService?.state = .success(result: Movies.buildDiscoveryMocks()!)
        mockInteractor?.isLoading = true

        sut?.viewDidLoad()

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

        sut?.viewDidLoad()

        if case MockDiscoverModuleView.State.showNoContent = mockView!.viewState {
            return
        }
        XCTFail("Wrong state, needs to be fixed!")
    }

    func test_whenFetchingData_onFailureResponse_showsErrorView() {
        let someError = AFError.explicitlyCancelled
        mockService?.state = .failure(error: someError)
        mockInteractor?.isLoading = true

        sut?.viewDidLoad()

        switch mockView?.viewState {
        case let .showError(error):
            XCTAssertEqual(someError.localizedDescription, error?.localizedDescription)
        default:
            XCTFail("Wrong state, needs to be fixed!")
        }
    }
}
