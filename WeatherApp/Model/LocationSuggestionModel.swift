//
//  LocationSuggestionModel.swift
//  WeatherApp
//
//  Created by Rushikesh on 03/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

// MARK: - LocationSuggestion
struct LocationSuggestion: Codable {
    let totalResults: Int
    let links: LOCSugLinks
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case totalResults
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let location: [Location]
}

// MARK: - Location
struct Location: Codable {
    let category: Category
    let id, name: String
    let position: Position
    let elevation: Int
    let timeZone, urlPath: String
    let country, region, subregion: Category
    let links: LocationLinks

    enum CodingKeys: String, CodingKey {
        case category, id, name, position, elevation, timeZone, urlPath, country, region, subregion
        case links = "_links"
    }
}

// MARK: - Category
struct Category: Codable {
    let id, name: String
}

// MARK: - LocationLinks
struct LocationLinks: Codable {
    let linksSelf, celestialevents, forecast, mapfeature: SelfElement
    let notifications, extremeforecasts, now: SelfElement
    let observations: [SelfElement]
    let airqualityforecast: SelfElement

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case celestialevents, forecast, mapfeature, notifications, extremeforecasts, now, observations, airqualityforecast
    }
}

// MARK: - SelfElement
struct SelfElement: Codable {
    let href: String
}

// MARK: - Position
struct Position: Codable {
    let lat, lon: Double
}

// MARK: - LOCSugLinks
struct LOCSugLinks: Codable {
    let linksSelf: SelfElement
    let page, search: Page
    let location: [SelfElement]

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case page, search, location
    }
}

// MARK: - Page
struct Page: Codable {
    let href: String
    let templated: Bool
}
