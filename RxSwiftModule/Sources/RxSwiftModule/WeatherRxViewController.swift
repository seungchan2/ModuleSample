//
//  WeatherRxViewController.swift
//  
//
//  Created by 김승찬 on 3/22/24.
//

import UIKit

import RxSwift
import RxCocoa

final class WeatherRxViewController: UIViewController {
    
    private var viewModel: WeatherRxViewModel
    private var disposeBag = DisposeBag()
    
    init(viewModel: WeatherRxViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bind()
    }
}

private extension WeatherRxViewController {
    func bind() {
        let input = WeatherRxViewModel.Input(viewDidLoadEvent: Observable.just(()))
        
        let output = viewModel.transform(input: input)
        
        output.fetchedWeatherData
            .drive(with: self) { owner, data in
                print(data)
            }
            .disposed(by: self.disposeBag)
    }
}
