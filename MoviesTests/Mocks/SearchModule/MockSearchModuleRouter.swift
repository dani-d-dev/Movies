//
//  MockSearchModuleRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 20/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit
@testable import Movies

class MockSearchModuleRouter: SearchModuleRouterProtocol {
    func presentDetailView(movie: Movie?, from vc: UIViewController) {
        // TODO:
    }
    
    func buildModule() -> UIViewController {
        return UIViewController()
    }
}
