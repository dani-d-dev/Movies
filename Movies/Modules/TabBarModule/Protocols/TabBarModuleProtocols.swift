//
//  TabBarModuleProtocols.swift
//  Movies
//
//  Created by Daniel Daverio on 27/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarModuleViewProtocol: class {
    var presenter: TabBarModulePresenterProtocol? { get set }
}

protocol TabBarModuleRouterProtocol: class {
    static func buildModule(using subModules: [TabBarViewProtocol]) -> UIViewController
}

protocol TabBarModulePresenterProtocol: class {
    var view: TabBarModuleViewProtocol? { get set }
    var interactor: TabBarModuleInteractorInputProtocol? { get set }
    var router: TabBarModuleRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectTab(index: Int)
}

protocol TabBarModuleInteractorOutputProtocol: class {}

protocol TabBarModuleInteractorInputProtocol: class {
    var presenter: TabBarModuleInteractorOutputProtocol? { get set }
}
