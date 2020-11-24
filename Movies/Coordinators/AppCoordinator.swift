//
//  AppCoordinator.swift
//  Movies
//
//  Created by Daniel Daverio on 26/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow!

    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }

    func initialize() {
        // TODO: Setup dependencies

        Constants.configureTheme()

        // Setup root module
        window.rootViewController = TabBarModuleRouter.buildModule(using: [DiscoverViewRouter(), SearchViewRouter()])
    }
}
