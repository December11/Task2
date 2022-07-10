//
//  ColorViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

final class ColorViewController: UIViewController {
    
    private let label = UILabel(.header)
    private var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .randomColor
        
        configureTapGesture()
        configureLabel()
    }
    
    private func configureTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeColorAction))
        guard let tapGesture = self.tapGesture else { return }
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureLabel() {
        label.text = "TAP"
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func changeColorAction() {
        view.backgroundColor = .randomColor
    }
}
