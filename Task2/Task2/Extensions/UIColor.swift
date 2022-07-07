//
//  UIColor.swift
//  Task2
//
//  Created by Alla Shkolnik on 01.07.2022.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        let color = UIColor(
            red: CGFloat.random(in: 155...255) / 255,
            green: CGFloat.random(in: 155...255) / 255,
            blue: CGFloat.random(in: 155...255) / 255,
            alpha: 1.0)
        
        return color
    }
}
