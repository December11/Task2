//
//  LibraryCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class LibraryCell: UITableViewCell {
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalTo(nameLabel.snp.bottom).inset(-4)
        }
        
    }
    
    func configurateCell(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
    }

}
