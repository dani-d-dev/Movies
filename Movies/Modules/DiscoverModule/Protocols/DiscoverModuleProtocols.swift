//
//  DiscoverModuleProtocols.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

protocol DiscoverModuleViewProtocol where Self: UIViewController {
    var presenter: DiscoverModulePresenterProtocol? { get set }

    func showLoadingView()
    func hideLoadingView()
    func showRetrievedData(movies: [MovieViewModel])
    func showNoContent()
    func showError(error: Error?)
}

protocol DiscoverModulePresenterProtocol: class {
    var view: DiscoverModuleViewProtocol? { get set }
    var interactor: DiscoverModuleInteractorInputProtocol? { get set }
    var router: DiscoverModuleRouterProtocol? { get set }

    func viewDidLoad()
    func loadNextPageIfNeeded()
    func didSelectItem(item: MovieViewModel?)
}

protocol DiscoverModuleInteractorInputProtocol: class {
    var presenter: DiscoverModuleInteractorOutputProtocol? { get set }
    var service: ApiClient? { get set }
    var pagination: PaginationInfo { get set }
    func fetchData(page: Int)
    func loadNextPageIfNeeded()
}

protocol DiscoverModuleInteractorOutputProtocol: class {
    func dataFetchedSuccess(movies: [Movie])
    func dataFetchedEmpty()
    func dataFetchedFailure(error: Error?)
}

protocol DiscoverModuleRouterProtocol: class {
    func presentDetailView(movie: Movie?, from vc: UIViewController)
    func buildModule() -> UIViewController
}

struct PaginationInfo {
    var totalPages: Int = 1
    var currentPage: Int = 0
    var hasReachedEnd: Bool { return totalPages == currentPage }
    
    mutating func reset() {
        totalPages = 1
        currentPage = 0
    }
    
}
