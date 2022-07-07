//
//  LibraryCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class LibraryCell: UITableViewCell {
    private let nameLabel = UILabel(.title)
    private let descriptionLabel = UILabel(.subTitle)
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
    
    func configurateCell(book: Book, completion: @escaping () -> Void) {
        nameLabel.text = book.name
        descriptionLabel.text = book.description
        completionHandler = completion
    }
    
    private func configurateUI() {
        configurateContentView()
        configurateButton()
    }
    
    private func configurateContentView() {
        let titleAndDescriptionStackView = labelsStackView()
        
        let cellContentStackView = UIStackView(arrangedSubviews: [titleAndDescriptionStackView, infoButton])
        contentView.addSubview(cellContentStackView)
        cellContentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        cellContentStackView.spacing = 16.0
    }
    
    private func labelsStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        
        return stackView
    }
    
    private func configurateButton() {
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
    }
    
    @objc private func infoButtonAction() {
        completionHandler?()
    }
}
