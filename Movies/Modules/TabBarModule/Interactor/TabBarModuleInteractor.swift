//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

final class TabBarModuleInteractor: TabBarModuleInteractorInputProtocol
{
    weak var presenter: TabBarModuleInteractorOutputProtocol?
    
    internal init(presenter: TabBarModuleInteractorOutputProtocol?) {
        self.presenter = presenter
    }
}
