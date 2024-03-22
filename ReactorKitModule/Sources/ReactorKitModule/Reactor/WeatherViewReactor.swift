//
//  WeatherViewReactor.swift
//
//
//  Created by MEGA_Mac on 2024/03/20.
//

import Foundation

import Network

import ReactorKit
import RxCocoa
import RxSwift

public final class WeatherViewReactor: Reactor {
    
    /// State의 초기값
    public let initialState = State()
    private let dependency: Dependency

    public struct Dependency {
        let weatherService: WeatherServiceImpl
    }
    
    /// 사용자 Action (Input)
    public enum Action {
        case viewDidLoad
    }
    
    public enum Mutation {
        case setCityWeather(WeatherModel)
    }
    
    public struct State {
        var weather = WeatherModel(title: "")
    }
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}

public extension WeatherViewReactor {
    /// 2. Action -> Mutation
    /// Action 처리방식
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return fetchWeather()
        }
    }
    
    /// 3. Mutation -> State
    /// 최종 State 반환
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setCityWeather(name):
            newState.weather = name
        }
        
        return newState
    }
    
    func fetchWeather() -> Observable<Mutation> {
        return dependency.weatherService.getCurrentWeather(for: "seoul")
            .asObservable()
            .map { .setCityWeather(WeatherModel(title: $0.name)) }
    }
}
