//
//  ItemDescriptionTableViewCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 20.07.2022.
//

import UIKit

final class ItemDescriptionTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let sideInsets = 16.0
    }
    
    private let descriptionLabel = UILabel(.regularText)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview().inset(Constants.sideInsets)
        }
    }
    
    func configure(description: String?) {
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
    }
    
}
