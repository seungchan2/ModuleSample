//
//  WeatherRxViewModel.swift
//
//
//  Created by 김승찬 on 3/22/24.
//

import Foundation

import Network

import RxSwift
import RxCocoa

public final class WeatherRxViewModel: ViewModelType {
    
    public struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    public struct Output {
        let fetchedWeatherData: Driver<WeatherModel>
    }
    
    public var disposeBag = DisposeBag()
    private let weatherService: WeatherServiceImpl
    
    public init(weatherService: WeatherServiceImpl) {
        self.weatherService = weatherService
    }
    
    public func transform(input: Input) -> Output {
        
        let fetchedData = PublishSubject<WeatherModel>()
        
        input.viewDidLoadEvent
            .map { self.weatherService.getCurrentWeather(for: "seoul") }
            .subscribe(with: self) { owner, data in
                print(data)
                fetchedData.onNext(WeatherModel(title: ""))
            }
            .disposed(by: self.disposeBag)
        
        
        
        return Output(fetchedWeatherData: fetchedData.asDriver(onErrorJustReturn: WeatherModel(title: "")))
    }
}
