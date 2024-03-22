//
//  ViewModelType.swift.swift
//
//
//  Created by MEGA_Mac on 2024/03/21.
//

import Combine
import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
