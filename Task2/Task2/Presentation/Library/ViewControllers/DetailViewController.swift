//
//  DetailViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 17.07.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private enum Constants {
        static let coverImageHeight = 240.0
        
        static let sideInsets = 16.0
        static let largeSideInsets = 40.0
        
        static let buttonTitle = "Закрыть"
    }
    
    private let coverImageView = UIImageView()
    private let titleLabel = UILabel(.header)
    private let descriptionLabel = UILabel(.regularText)
    private let closeButton = UIButton()
    
    var itemURLString: String?
    var itemTitle: String?
    var itemDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent(coverURLString: itemURLString, title: itemTitle, description: itemDescription)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        configureUI()
    }
    
    private func setupContent(coverURLString: String?, title: String?, description: String?) {
        guard
            let urlString = coverURLString,
            let url = URL(string: urlString),
            let title = title,
            let description = description
        else { return }
        coverImageView.kf.setImage(with: url)
        titleLabel.text = title
        descriptionLabel.text = description
        
        closeButton.setTitle(Constants.buttonTitle, for: .normal)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        configureCover()
        configureTitleLabel()
        configureDescriptionLabel()
        configureButton()
    }
    
    private func configureCover() {
        coverImageView.contentMode = .scaleAspectFill
        
        view.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Constants.coverImageHeight)
        }
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInsets)
            make.bottom.equalTo(coverImageView.snp.bottom).inset(Constants.sideInsets)
        }
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInsets)
            make.top.equalTo(coverImageView.snp.bottom).inset(-Constants.sideInsets)
        }
    }
    
    private func configureButton() {
        closeButton.backgroundColor = .systemBlue
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInsets)
            make.bottom.equalToSuperview().inset(Constants.largeSideInsets)
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).inset(Constants.largeSideInsets)
        }
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }
    
}
