//
//  MockSearchModuleView.swift
//  Movies
//
//  Created by Daniel Daverio on 20/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit
@testable import Movies

class MockSearchModuleView: UIViewController, SearchModuleViewProtocol {
    enum State {
        case showRetrievedData(viewModels: [MovieViewModel])
        case showNoContent
        case showError(Error?)
    }

    var startLoading = false
    var stopsLoading = false
    var showPlaceholder = false
    var hidePlaceholder = false

    var viewState: State = .showNoContent
    var presenter: SearchModulePresenterProtocol?

    func showLoadingView() {
        startLoading = true
        stopsLoading = false
    }

    func hideLoadingView() {
        startLoading = false
        stopsLoading = true
    }

    func showPlaceholderView() {
        showPlaceholder = true
        hidePlaceholder = false
    }

    func hidePlaceholderView() {
        showPlaceholder = false
        hidePlaceholder = true
    }

    func showRetrievedData(movies: [MovieViewModel]) {
        viewState = .showRetrievedData(viewModels: movies)
    }

    func showNoContent() {
        viewState = .showNoContent
    }

    func showError(error: Error?) {
        viewState = .showError(error)
    }
}
