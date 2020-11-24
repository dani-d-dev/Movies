//
//  DetailModuleProtocols.swift
//  Movies
//
//  Created by Daniel Daverio on 12/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

protocol DetailModuleViewProtocol: class {
    var presenter: DetailModulePresenterProtocol? { get set }

    func showDetail(item: MovieViewModel)
    func showDetailError()
}

protocol DetailModulePresenterProtocol: class {
    var view: DetailModuleViewProtocol? { get set }
    var interactor: DetailModuleInteractorProtocol? { get set }
    var router: DetailModuleRouterProtocol? { get set }
    func loadMovieDetail()
}

protocol DetailModuleInteractorProtocol: class {
    var item: Movie? { get set }
}

protocol DetailModuleRouterProtocol: class {
    static func buildModule(movie: Movie?) -> UIViewController
}
