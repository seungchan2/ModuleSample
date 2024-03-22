//
//  WeatherCombineViewController.swift
//
//
//  Created by MEGA_Mac on 2024/03/21.
//

import Combine
import UIKit

import Core

import CombineDataSources
import SnapKit

public final class WeatherCombineViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .yellow
        return textField
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        return collectionView
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        return flowLayout
    }()
    
    private var viewModel: WeatherCombineViewModel
    private var cancelBag = CancelBag()
    
    public init(viewModel: WeatherCombineViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("WeatherViewController Error!")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStyle()
        self.setLayout()
        self.bind()
    }
}

private extension WeatherCombineViewController {
    func setStyle() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = .white
        
        [textField, collectionView].forEach { self.view.addSubview($0) }
    }
    
    func setLayout() {
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    func bind() {
        let input = WeatherCombineViewModel.Input(inputTextFieldText: self.textField.publisher)
        
        let output = viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.weatherData
            .map { $0 }
            .receive(on: RunLoop.main)
            .subscribe(self.collectionView.itemsSubscriber(cellIdentifier: "WeatherCell",
                                                           cellType: WeatherCell.self,
                                                           cellConfig: { cell, indexPath, data in
                cell.convertDataToUI(from: data)
            }))
    }
}
