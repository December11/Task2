//
//  DetailTitleTableViewCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 20.07.2022.
//

import UIKit

final class DetailTitleTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let sideInsets = 16.0
    }
    
    private let titleLabel = UILabel(.header)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.sideInsets)
            make.horizontalEdges.bottom.equalToSuperview().inset(Constants.sideInsets)
        }
    }
    
    func configure(title: String?) {
        titleLabel.text = title
        titleLabel.numberOfLines = 0
    }
                   
}
