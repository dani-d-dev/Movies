//
//  TabBarViewProtocol.swift
//  Movies
//
//  Created by Daniel Daverio on 27/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarViewProtocol {
    func buildTabBarItem() -> UITabBarItem
    func buildModule() -> UIViewController
}
