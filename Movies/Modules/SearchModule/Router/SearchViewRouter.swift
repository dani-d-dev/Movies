//
//  SecondViewRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

class SearchViewRouter: SearchModuleRouterProtocol, TabBarViewProtocol {
    
    func buildModule() -> UIViewController {
        let vc = SearchView(nibName: SearchView.className, bundle: nil)
        let presenter = SearchViewPresenter(view: vc)
        presenter.interactor = SearchViewInteractor(presenter: presenter)
        let router = SearchViewRouter()
        presenter.router = router
        vc.presenter = presenter
        return vc
    }

    func buildTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search_icon"), tag: 1)
    }

    func presentDetailView(movie: Movie?, from vc: UIViewController) {
        let detailVc = DetailViewRouter.buildModule(movie: movie)
        vc.navigationController?.pushViewController(detailVc, animated: true)
    }
}
