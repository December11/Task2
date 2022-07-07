//
//  UILabel.swift
//  Task2
//
//  Created by Alla Shkolnik on 07.07.2022.
//

import UIKit

extension UILabel {
    
    enum TextStyle {
        case header
        case title
        case subTitle
    }
    
    convenience init(_ textStyle: TextStyle) {
        self.init()
        
        self.numberOfLines = 2
        self.lineBreakMode = .byWordWrapping
        
        switch textStyle {
        case .header:
            self.textColor = UIColor.black
            self.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        case .title:
            self.font = .systemFont(ofSize: 16, weight: .heavy)
        case .subTitle:
            self.font = .systemFont(ofSize: 14)
            self.textColor = .systemGray
        }
    }
}
