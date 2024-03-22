//
//  WeatherEntity.swift
//
//
//  Created by MEGA_Mac on 2024/03/20.
//

import Foundation

public struct WeatherEntity: Codable {
    public let weather: [Weather]
    public let main: WeatherMain
    public let wind: WeatherWind
    public let name: String
}

public struct Weather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

public struct WeatherMain: Codable {
    public let temp: Double
    public let feels_like: Double
    public let temp_min: Double
    public let temp_max: Double
    public let pressure: Int
    public let humidity: Int
}

public struct WeatherWind: Codable {
    public let speed: Double
}
