//
//  ViewModelType.swift
//
//
//  Created by 김승찬 on 3/22/24.
//

import Foundation

import RxSwift

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
