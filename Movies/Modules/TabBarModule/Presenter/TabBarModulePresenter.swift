//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

final class TabBarModulePresenter: TabBarModulePresenterProtocol
{
    weak var view: TabBarModuleViewProtocol?
    internal var interactor: TabBarModuleInteractorInputProtocol?
    internal var router: TabBarModuleRouterProtocol?
    
    internal init(
        view: TabBarModuleViewProtocol?,
        interactor: TabBarModuleInteractorInputProtocol? = nil,
        router: TabBarModuleRouterProtocol? = nil
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        print("TabBarModulePresenter: viewDidLoad called")
    }
    
    func didSelectTab(index: Int) {
        print("TabBarModulePresenter didSelectTab index: \(index) called")
    }
}

extension TabBarModulePresenter: TabBarModuleInteractorOutputProtocol {}
