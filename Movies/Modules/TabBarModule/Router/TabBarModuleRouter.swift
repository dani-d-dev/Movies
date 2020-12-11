//
//  TabBarModuleRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 27/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

final class TabBarModuleRouter: TabBarModuleRouterProtocol {
    
    static func buildModule(using subModules: [TabBarViewProtocol]) -> UIViewController {
        let tbc = TabBarView(nibName: TabBarView.className, bundle: nil)
        let presenter = TabBarModulePresenter(view: tbc)
        presenter.interactor = TabBarModuleInteractor(presenter: presenter)
        let router = TabBarModuleRouter()
        presenter.router = router
        tbc.presenter = presenter

        // populate tabbar vc's

        tbc.viewControllers = subModules.map { view -> UIViewController in
            let vc = view.buildModule()
            let nvc = UINavigationController(rootViewController: vc)
            let tabBarItem = view.buildTabBarItem()
            nvc.tabBarItem = tabBarItem
            nvc.title = tabBarItem.title
            return nvc
        }

        return tbc
    }
}
