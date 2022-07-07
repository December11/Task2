//
//  ColorViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

final class ColorViewController: UIViewController {
    private let label = UILabel(.header)
    private var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTapGesture()
        configurateLabel()
        view.backgroundColor = .randomColor
    }
    
    private func configurateTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeColorAction))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    private func configurateLabel() {
        label.text = "TAP"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc private func changeColorAction() {
        view.backgroundColor = .randomColor
    }
}
