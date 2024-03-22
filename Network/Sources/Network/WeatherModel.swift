//
//  WeatherModel.swift
//  
//
//  Created by MEGA_Mac on 2024/03/20.
//

import Foundation

public struct WeatherModel: Hashable {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}
