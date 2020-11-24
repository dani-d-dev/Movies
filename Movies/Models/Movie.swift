//
//  Movie.swift
//  Movies
//
//  Created by Daniel Daverio on 04/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable {
    let id: Int
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String?
    let genreIDS: [Int]
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

extension Movie {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        let path = try? container.decode(String.self, forKey: CodingKeys.posterPath)
        posterPath = path != nil ? Constants.API.baseImageURL.absoluteString + path! : nil
        adult = try container.decode(Bool.self, forKey: CodingKeys.adult)
        overview = try container.decode(String.self, forKey: CodingKeys.overview)
        releaseDate = try? container.decode(String.self, forKey: CodingKeys.releaseDate)
        genreIDS = try container.decode([Int].self, forKey: CodingKeys.genreIDS)
        originalTitle = try container.decode(String.self, forKey: CodingKeys.originalTitle)
        originalLanguage = try container.decode(String.self, forKey: CodingKeys.originalLanguage)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        backdropPath = try? container.decode(String.self, forKey: CodingKeys.backdropPath)
        popularity = try container.decode(Double.self, forKey: CodingKeys.popularity)
        voteCount = try container.decode(Int.self, forKey: CodingKeys.voteCount)
        video = try container.decode(Bool.self, forKey: CodingKeys.video)
        voteAverage = try container.decode(Double.self, forKey: CodingKeys.voteAverage)
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        // Check only against id at the moment...
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}
