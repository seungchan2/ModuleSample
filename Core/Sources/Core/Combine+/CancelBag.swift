//
//  CancelBag.swift
//
//
//  Created by MEGA_Mac on 2024/03/21.
//

import Combine
import Foundation

open class CancelBag {
    public var subscriptions = Set<AnyCancellable>()
    
    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    public init() {}
}

extension AnyCancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
