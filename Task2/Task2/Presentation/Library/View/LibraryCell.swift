//
//  LibraryCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class LibraryCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let infoButton = UIButton()
    private var completionHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        infoButton.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
        configurateUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateCell(name: String, description: String, completion: @escaping () -> Void) {
        nameLabel.text = name
        descriptionLabel.text = description
        self.completionHandler = completion
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
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
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
    
    @objc private func infoButtonAction() {
        completionHandler?()
    }
}
