//
//  UITextField+.swift
//  
//
//  Created by MEGA_Mac on 2024/03/21.
//

import Combine
import UIKit.UITextField

public extension UITextField {
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField}
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }
    
    func addPadding(width: CGFloat) {
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = ViewMode.always
        
        let rightPaddingView = UIView(frame: CGRect(x: 350, y: 0, width: width, height: self.frame.height))
        
        self.rightView = rightPaddingView
        self.rightViewMode = ViewMode.always
    }
}
