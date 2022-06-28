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
        configurateStackViews()
        configureNameLabel()
        configureDescriptionLabel()
    }
    
    private func configurateStackViews() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        stackView.axis = .vertical
        stackView.spacing = 4.0
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
