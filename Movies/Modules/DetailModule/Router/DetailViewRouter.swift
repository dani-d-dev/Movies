//
//  DetailViewRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 12/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

class DetailViewRouter: DetailModuleRouterProtocol {
    static func buildModule(movie: Movie?) -> UIViewController {
        let vc = DetailView(nibName: DetailView.className, bundle: nil)
        let presenter = DetailViewPresenter(view: vc)
        presenter.interactor = DetailViewInteractor(item: movie)
        presenter.router = DetailViewRouter()
        vc.presenter = presenter
        return vc
    }
}
