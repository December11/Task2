//
//  ColorViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

final class ColorViewController: UIViewController {
    
    let label = UILabel()
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Color"
        configurateTapGesture()
        configurateLabel()
        view.backgroundColor = UIColor.randomColor
    }
    
    private func configurateTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    private func configurateLabel() {
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.text = "TAP"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        view.backgroundColor = UIColor.randomColor
    }
}
