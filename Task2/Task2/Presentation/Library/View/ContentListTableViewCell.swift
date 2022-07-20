//
//  ContentListTableViewCell.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import Kingfisher
import UIKit

final class ContentListTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let infoImageTitle = "info.circle"
        
        static let infoButtonWidth = 24.0
        static let newsCoverWidth = 108.0
        static let bookCoverWidth = 80.0
        
        static let defaultSideInsets = 16.0
        static let smallSideInsets = 8.0
        static let labelSpacing = 2.0
        
        static let separatorHeight = 1 / UIScreen.main.nativeScale
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
    
    func configure(item: Fetchable, completion: @escaping () -> Void) {
        nameLabel.text = item.title
        if let description = item.shortDescription {
            descriptionLabel.text = description
        }
        if let imageURLString = item.imageURLString {
            let url = URL(string: imageURLString)
            coverImageView.kf.setImage(with: url)
        }
        completionHandler = completion
    }
    
    private func configureUI() {
        configureInfoButton()
        configureImageView()
        configureLabelStackView()
        makeSeparator()
    }
    
    private func configureImageView() {
        coverImageView.backgroundColor = .systemGray6
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.width.equalTo(Constants.newsCoverWidth)
        }
    }
    
    private func configureInfoButton() {
        infoButton.setImage(UIImage(systemName: Constants.infoImageTitle), for: .normal)
        
        contentView.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.defaultSideInsets)
            make.centerY.equalToSuperview()
            make.width.equalTo(Constants.infoButtonWidth)
        }
    }
    
    private func configureLabelStackView() {
        descriptionLabel.lineBreakMode = .byTruncatingTail
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.labelSpacing
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.defaultSideInsets)
            make.trailing.lessThanOrEqualTo(infoButton.snp.leading).inset(-Constants.defaultSideInsets)
            make.leading.equalTo(coverImageView.snp.trailing).inset(-Constants.smallSideInsets)
        }
    }
    
    private func makeSeparator() {
        separatorView.backgroundColor = .systemGray2
        contentView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.defaultSideInsets)
            make.height.equalTo(Constants.separatorHeight)
        }
    }
    
    @objc private func infoButtonAction() {
        completionHandler?()
    }
    
}
