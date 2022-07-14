//
//  LibraryTableViewCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class LibraryTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let imageTitle = "info.circle"
        static let sideInsets = 16.0
    }
    
    private let coverImageView = UIImageView()
    private let nameLabel = UILabel(.title)
    private let descriptionLabel = UILabel(.subTitle)
    private let infoButton = UIButton()
    private var completionHandler: (() -> Void)?
    
    let separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        infoButton.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
        
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) error")
    }
    
    func configure(book: Book, completion: @escaping () -> Void) {
        nameLabel.text = book.name
        descriptionLabel.text = book.description
        completionHandler = completion
    }
    
    private func configureUI() {
        configureInfoButton()
        configureLabelStackView()
        makeSeparator()
    }
    
    private func configureImageView() {
        imageView?.backgroundColor = .systemGray5
        
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(160)
            make.leading.equalToSuperview().inset(Constants.sideInsets)
        }
    }
    
    private func configureInfoButton() {
        infoButton.setImage(UIImage(systemName: Constants.imageTitle), for: .normal)
        
        contentView.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.sideInsets)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureLabelStackView() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.sideInsets)
            make.trailing.lessThanOrEqualTo(infoButton.snp.leading).inset(-Constants.sideInsets)
            make.leading.lessThanOrEqualTo(coverImageView.snp.trailing).inset(Constants.sideInsets)
        }
    }
    
    private func makeSeparator() {
        separatorView.backgroundColor = .systemGray2
        contentView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.sideInsets)
            make.height.equalTo(1 / UIScreen.main.nativeScale)
        }
    }
    
    @objc private func infoButtonAction() {
        completionHandler?()
    }
    
}
