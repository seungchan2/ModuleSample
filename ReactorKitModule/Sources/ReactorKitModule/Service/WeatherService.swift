//
//  WeatherService.swift
//  
//
//  Created by MEGA_Mac on 2024/03/20.
//

import Foundation

import Network

import RxSwift
import RxCocoa

public protocol WeatherServiceImpl {
    func getCurrentWeather(for city: String) -> Single<WeatherEntity>
}

public final class WeatherService: WeatherServiceImpl {
    
    private let key = "65f7dabad2ae1cab0ce9cbef2aea7932"
    public func getCurrentWeather(for city: String) -> Single<WeatherEntity> {
        return Single.create { single in
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(self.key)") else {
                return Disposables.create()
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data else { return }

                do {
                    let weatherEntity = try JSONDecoder().decode(WeatherEntity.self, from: data)
                    single(.success(weatherEntity))
                    dump(weatherEntity)
                } catch {
                    print("에러처리")
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
