//
//  FirebaseAnalyticsService.swift
//  Movies
//
//  Created by Daniel Daverio on 15/12/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseAnalyticsService: AnalyticsServiceProtocol {
    
    func initialize() {
        FirebaseApp.configure()
    }
    
    func track(event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.param)
    }
}
