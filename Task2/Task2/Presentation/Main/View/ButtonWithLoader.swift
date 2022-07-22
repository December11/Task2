//
//  ButtonWithLoader.swift
//  Task2
//
//  Created by Alla Shkolnik on 17.07.2022.
//

import UIKit

final class ButtonWithLoader: UIButton {
    
    private enum Constants {
        static let buttonsHeight = 60.0
        static let conderRadius = 16.0
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    
    var title: String? {
        willSet {
            setTitle(newValue, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func startLoadAnimation() {
        setTitle("", for: .normal)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoadAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        setTitle(title, for: .normal)
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        layer.cornerRadius = Constants.conderRadius
        setTitleColor(.black, for: .normal)
        activityIndicator.color = .black
        
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Constants.buttonsHeight)
        }
        
        activityIndicator.isHidden = true
    }
    
}
