//
//  ColorViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

final class ColorViewController: UIViewController {
    
    private enum Constants {
        static let childVCHeight = (UIScreen.main.bounds.height / 2).rounded()
    }
    
    private let topChildViewController = UIViewController()
    private let bottomChildViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            topChildViewController.view.backgroundColor = .randomColors.topColor
            bottomChildViewController.view.backgroundColor = .randomColors.bottomColor
        }
    }
    
    private func configureUI() {
        topChildViewController.view.backgroundColor = .randomColors.topColor
        bottomChildViewController.view.backgroundColor = .randomColors.bottomColor
        
        add(topChildViewController)
        topChildViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.childVCHeight)
        }
        
        add(bottomChildViewController)
        bottomChildViewController.view.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.childVCHeight)
        }
    }
    
}

fileprivate extension UIColor {
    
    static var randomColors: (topColor: UIColor, bottomColor: UIColor) {
        let halfSpectral = CGFloat(round(255 / 2))
        let randomHue = CGFloat.random(in: 1...255)
        
        return randomHue > halfSpectral
        ? (
            UIColor(hue: (halfSpectral + randomHue) / 255, saturation: 0.5, brightness: 0.9, alpha: 1),
            UIColor(hue: randomHue / 255, saturation: 0.5, brightness: 0.9, alpha: 1)
        )
        : (
            UIColor(hue: (halfSpectral - randomHue) / 255, saturation: 0.5, brightness: 0.9, alpha: 1),
            UIColor(hue: randomHue / 255, saturation: 0.5, brightness: 0.9, alpha: 1)
        )
    }
    
}

fileprivate extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
