//
//  WeatherService.swift
//
//
//  Created by MEGA_Mac on 2024/03/21.
//

import Foundation
import Combine

import Network

public enum NetworkError: Error {
    case invalidURL
    case requestFailed
}

public protocol WeatherServiceImpl {
    func getCurrentWeather(for city: String) -> AnyPublisher<WeatherEntity, NetworkError>
}

public final class WeatherService: WeatherServiceImpl {
    private let key = "65f7dabad2ae1cab0ce9cbef2aea7932"
    
    public init() {}
    /*
     AnyPublisher를 바로 Return
     RxSwift -> Observable
     */
    public func getCurrentWeather(for city: String) -> AnyPublisher<WeatherEntity, NetworkError> {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(self.key)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherEntity.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.requestFailed
            }
            .eraseToAnyPublisher()
    }
    
    /*
     Future를 바로 Return
     RxSwift -> Single
     */
    public func getCurrentWeather(for city: String) -> Future<WeatherEntity, NetworkError> {
        return Future<WeatherEntity, NetworkError> { promise in
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(self.key)") else {
                promise(.failure(NetworkError.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data else {
                    promise(.failure(NetworkError.invalidURL))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(WeatherEntity.self, from: data)
                    promise(.success(decodedData))
                } catch {
                    promise(.failure(NetworkError.invalidURL))
                }
            }
            .resume()
        }
    }
}
