//
//  SecondModuleProtocols.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

protocol SearchModuleViewProtocol where Self: UIViewController
{
    var presenter: SearchModulePresenterProtocol? { get set }
    
    func showPlaceholderView()
    func hidePlaceholderView()
    func showLoadingView()
    func hideLoadingView()
    func showRetrievedData(movies: [MovieViewModel])
    func showNoContent()
    func showError(error: Error?)
}

protocol SearchModulePresenterProtocol: class
{
    var view: SearchModuleViewProtocol? { get set }
    var interactor: SearchModuleInteractorInputProtocol? { get set }
    var router: SearchModuleRouterProtocol? { get set }
    
    func viewDidLoad()
    func search(movie: String)
    func cancel()
    func didSelectItem(item: MovieViewModel?)
}

protocol SearchModuleInteractorInputProtocol: class
{
    var presenter: SearchModuleInteractorOutputProtocol? { get set }
    var service: ApiClient? { get set }
    var pagination: PaginationInfo { get set }
    var lastSearch: String? { get set }
    
    func search(movie: String)
    func cancel()
}

protocol SearchModuleInteractorOutputProtocol: class
{
    func dataFetchedSuccess(movies: [Movie])
    func dataFetchedEmpty()
    func dataFetchedFailure(error: Error?)
}

protocol SearchModuleRouterProtocol: class
{
    func presentDetailView(movie: Movie?, from vc: UIViewController)
    func buildModule() -> UIViewController
}
