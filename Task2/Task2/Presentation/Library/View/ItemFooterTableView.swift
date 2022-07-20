//
//  ItemFooterTableView.swift
//  Task2
//
//  Created by Alla Shkolnik on 20.07.2022.
//

import UIKit

final class ItemFooterTableView: UITableViewHeaderFooterView {
    
    private enum Constants {
        static let sideInsets = 16.0
        static let buttonHeight = 60.0
    }
    
    private let closeButton = UIButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        closeButton.backgroundColor = .systemBlue
        
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.sideInsets)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    
}
