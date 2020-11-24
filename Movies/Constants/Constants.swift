//
//  Constants.swift
//  Movies
//
//  Created by Daniel Daverio on 04/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct API {
        static let baseURL = URL(string: "https://api.themoviedb.org")!
        static let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")!
        static let apiKey = "8b2cea5b14d8ec7d3d4c76b5480d012c"
        static let apiKeyName = "api_key"
        static let discover = "/3/discover/movie"
        static let search = "/3/search/movie"
    }
    
    static func configureTheme() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barStyle = .blackOpaque
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barStyle = .blackOpaque
        tabBarAppearance.tintColor = .white
        tabBarAppearance.barTintColor = .black
        tabBarAppearance.isTranslucent = false

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white

        if #available(iOS 13.0, *) {
            let navigationBarAppearanceProxy = UINavigationBar.appearance()
            let navigationBarAppearance = UINavigationBarAppearance()

            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = navigationBarAppearanceProxy.barTintColor
            navigationBarAppearance.titleTextAttributes = navigationBarAppearanceProxy.titleTextAttributes ?? [:]
            navigationBarAppearance.largeTitleTextAttributes = navigationBarAppearanceProxy.largeTitleTextAttributes ?? [:]

            navigationBarAppearanceProxy.scrollEdgeAppearance = navigationBarAppearance
            navigationBarAppearanceProxy.compactAppearance = navigationBarAppearance
            navigationBarAppearanceProxy.standardAppearance = navigationBarAppearance

            let tabBarAppearanceProxy = UITabBar.appearance()
            let tabAppearance = UITabBarAppearance()

            tabAppearance.configureWithOpaqueBackground()
            tabAppearance.backgroundColor = tabBarAppearanceProxy.barTintColor

            return
        }
    }
}
