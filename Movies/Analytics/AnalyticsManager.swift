//
//  AnalyticsManager.swift
//  Movies
//
//  Created by Daniel Daverio on 15/12/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

final class AnalyticsManager: AnalyticsServiceProtocol {
    internal private(set) var services = [AnalyticsServiceProtocol]()

    static let instance = AnalyticsManager()
    private init() {}

    func add(services: [AnalyticsServiceProtocol]) {
        self.services.append(contentsOf: services)
    }

    func initialize() {
        services.forEach { $0.initialize() }
    }

    func track(event: AnalyticsEvent) {
        for service in services where service.shouldTrack(event: event) {
            service.track(event: event)
        }
    }
}
