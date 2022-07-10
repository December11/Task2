//
//  UIColor+randomColor.swift
//  Task2
//
//  Created by Alla Shkolnik on 01.07.2022.
//

import UIKit

extension UIColor {
    
    static var randomColor: UIColor {
        let color = UIColor(
            hue: CGFloat.random(in: 0...255) / 255,
            saturation: 0.5,
            brightness: 0.9,
            alpha: 1)
        return color
    }
}
