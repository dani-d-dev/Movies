//
//  DiscoverViewRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

final class DiscoverViewRouter: DiscoverModuleRouterProtocol, TabBarViewProtocol {
    
    func buildModule() -> UIViewController {
        let vc = DiscoverView(nibName: DiscoverView.className, bundle: nil)
        let presenter = DiscoverViewPresenter(view: vc)
        presenter.interactor = DiscoverViewInteractor(presenter: presenter)
        let router = DiscoverViewRouter()
        presenter.router = router
        vc.presenter = presenter
        return vc
    }

    func buildTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "Discover", image: #imageLiteral(resourceName: "compass_icon"), tag: 0)
    }

    func presentDetailView(movie: Movie?, from vc: UIViewController) {
        let detailVc = DetailViewRouter.buildModule(movie: movie)
        vc.navigationController?.pushViewController(detailVc, animated: true)
    }
}
