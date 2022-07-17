//
//  UILabel+TextStyle.swift
//  Task2
//
//  Created by Alla Shkolnik on 07.07.2022.
//

import UIKit

extension UILabel {
    
    enum TextStyle {
        case header
        case title
        case regularText
        case subTitle
    }
    
    convenience init(_ textStyle: TextStyle) {
        self.init()
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 2
        
        switch textStyle {
            
        case .header:
            self.font = .systemFont(ofSize: 24, weight: .heavy)
            
        case .title:
            self.font = .systemFont(ofSize: 16, weight: .heavy)
            
        case .regularText:
            self.font = .systemFont(ofSize: 16)
            
        case .subTitle:
            self.textColor = .systemGray
            self.font = .systemFont(ofSize: 14)
        }
    }
    
}
