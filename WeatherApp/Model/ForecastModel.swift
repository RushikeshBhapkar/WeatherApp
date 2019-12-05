//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Rushikesh on 04/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let links: Links
    let created, update: Date
    let shortIntervals: [ShortInterval]
    let longIntervals: [LongInterval]

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case created, update, shortIntervals, longIntervals
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

// MARK: - LongInterval
struct LongInterval: Codable {
    let symbol: Symbol
    let precipitation, temperature: Precipitation
    let wind: Wind
    let feelsLike, pressure: DewPoint
    let cloudCover: CloudCover
    let humidity, dewPoint: DewPoint
    let start, end: Date
}

// MARK: - CloudCover
struct CloudCover: Codable {
    let value, high, middle, low: Int
    let fog: Int
}

// MARK: - DewPoint
struct DewPoint: Codable {
    let value: Double?
}

// MARK: - Precipitation
struct Precipitation: Codable {
    let min, max: Double?
    let value: Double
    let pop: Int?
}

// MARK: - Symbol
struct Symbol: Codable {
    let n, clouds, precip: Int
    let symbolVar: Var?
    let sunup: Bool
    let precipPhase: String?

    enum CodingKeys: String, CodingKey {
        case n, clouds, precip
        case symbolVar = "var"
        case sunup, precipPhase
    }
}

enum Var: String, Codable {
    case moon = "Moon"
    case sun = "Sun"
}

// MARK: - Wind
struct Wind: Codable {
    let direction: Int
    let gust: Double?
    let speed: Double
}

// MARK: - ShortInterval
struct ShortInterval: Codable {
    let symbol: Symbol
    let precipitation: Precipitation
    let temperature: DewPoint
    let wind: Wind
    let feelsLike, pressure: DewPoint
    let cloudCover: CloudCover
    let humidity, dewPoint: DewPoint
    let start, end: Date
}
