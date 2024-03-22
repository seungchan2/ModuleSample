//
//  WeatherReactorViewController.swift
//
//
//  Created by MEGA_Mac on 2024/03/20.
//

import UIKit

import Network
import Core

import ReactorKit
import RxCocoa

public final class WeatherViewController: UIViewController, View {
    public typealias Reactor = WeatherViewReactor
    public var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initReactor()
    }
}

private extension WeatherViewController {
    func initReactor() {
        self.reactor = WeatherViewReactor(dependency: WeatherViewReactor.Dependency(weatherService: WeatherService()))
    }
}

public extension WeatherViewController {
    func bind(reactor: WeatherViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: WeatherViewReactor) {
        /// 1. View -> Action
        Observable.just(())
            .map { _ in Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func bindState(_ reactor: WeatherViewReactor) {
        /// 4. State -> View
        reactor.state
            .map { $0.weather }
            .asDriver(onErrorJustReturn: WeatherModel(title: ""))
            .drive(with: self) { owner, weatherModel in
                /// UI 업데이트
                print("title", weatherModel.title)
            }
            .disposed(by: self.disposeBag)
    }
}
