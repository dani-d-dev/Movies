//
//  AnalyticsServiceProtocol.swift
//  Movies
//
//  Created by Daniel Daverio on 15/12/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

protocol AnalyticsServiceProtocol {
    func initialize()
    func track(event: AnalyticsEvent)
    var trackingEvents: [String] { get }
}

extension AnalyticsServiceProtocol {
    func shouldTrack(event: AnalyticsEvent) -> Bool { return trackingEvents.contains(event.name) }
    var trackingEvents: [String] { return AnalyticsEvent.allNames }
}

enum AnalyticsEvent {
    case showDiscoveryScreen
    case showSearchScreen
    case searchMovie(name: String)
    
    var name: String {
        switch self {
        case .showDiscoveryScreen: return "show_discovery_screen"
        case .showSearchScreen: return "show_search_screen"
        case .searchMovie(_): return "search_movie"
        }
    }

    var param: [String: String] {
        switch self {
        case .showDiscoveryScreen: return [name: "Show discovery screen"]
        case .showSearchScreen: return [name: "Show search screen"]
        case let .searchMovie(movie): return [name: movie]
        }
    }
}

extension AnalyticsEvent {
    static var allNames = ["show_discovery_screen", "show_search_screen", "search_movie"]
}
