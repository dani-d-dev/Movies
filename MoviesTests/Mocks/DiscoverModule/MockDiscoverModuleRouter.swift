//
//  MockDiscoverModuleRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 05/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit
@testable import Movies

class MockDiscoverModuleRouter: DiscoverModuleRouterProtocol {
    func presentDetailView(movie: Movie?, from vc: UIViewController) {
        // TODO:
    }
    
    func buildModule() -> UIViewController {
        return UIViewController()
    }
}
