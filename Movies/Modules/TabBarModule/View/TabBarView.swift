//
//  TabBarView.swift
//  Movies
//
//  Created by Daniel Daverio on 27/10/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import UIKit

class TabBarView: UITabBarController, TabBarModuleViewProtocol {
    internal var presenter: TabBarModulePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        presenter?.didSelectTab(index: item.tag)
    }

}
