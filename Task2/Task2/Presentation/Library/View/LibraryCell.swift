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
    let infoButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateUI() {
        configurateContentView()
        configurateButton()
        configureNameLabel()
        configureDescriptionLabel()
    }
    
    private func configurateContentView() {
        let titleAndDescriptionStackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        let cellContentStackView = UIStackView(arrangedSubviews: [titleAndDescriptionStackView, infoButton])
        contentView.addSubview(cellContentStackView)
        
        cellContentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        cellContentStackView.spacing = 16.0
        
        titleAndDescriptionStackView.axis = .vertical
        titleAndDescriptionStackView.spacing = 4.0
    }
    
    private func configurateButton() {
        infoButton.setImage(UIImage.init(systemName: "info.circle"), for: .init())
    }
    
    private func configureNameLabel() {
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor.systemGray
    }
    
    func configurateCell(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
    }
}