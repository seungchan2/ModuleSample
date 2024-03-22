//
//  WeatherCombineViewModel.swift
//
//
//  Created by MEGA_Mac on 2024/03/21.
//

import Combine
import Foundation

import Network
import Core

public final class WeatherCombineViewModel: ViewModelType {
    
    private var cancelBag = CancelBag()
    private var weatherService: WeatherServiceImpl
    
    public init(weatherService: WeatherServiceImpl) {
        self.weatherService = weatherService
    }
    
    public struct Input {
        let inputTextFieldText: AnyPublisher<String, Never>
    }
    
    public struct Output {
        let weatherData = PassthroughSubject<[WeatherModel], Never>()
    }
    
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.inputTextFieldText
            .throttle(for: 1.0, scheduler: DispatchQueue.main, latest: true)
            .flatMap { city in
                return self.weatherService.getCurrentWeather(for: city)
                    .catch { error in
                        output.weatherData.send([])
                        return Empty<WeatherEntity, Never>().eraseToAnyPublisher()
                    }
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { weatherData in
                let fetchedData = [WeatherModel(title: weatherData.name)]
                output.weatherData.send(fetchedData)
            }
            .store(in: self.cancelBag)
            
        return output
    }
}
