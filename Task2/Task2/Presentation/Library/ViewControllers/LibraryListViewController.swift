//
//  LibraryListViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 13.07.2022.
//

import UIKit

final class LibraryListViewController: UIViewController {
    
    private enum Constants {
        static let spacing = 8.0
        static let buttonsHeight = 60.0
        static let conderRadius = 16.0
        static let sideInsets = 24.0
        
        static let booksButtonTitle = "Книги"
        static let newsButtonTitle = "Новости"
        static let randomButtonTitle = "Случайные"
        static let shuffleButtonTitle = "В перемешку"
    }
    
    private let bookButton = UIButton()
    private let newsButton = UIButton()
    private let randomButton = UIButton()
    private let shuffleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bookButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        newsButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        shuffleButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        configureUI()
    }
    
    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [bookButton, newsButton, randomButton, shuffleButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        
        configureButton(bookButton, title: Constants.booksButtonTitle)
        configureButton(newsButton, title: Constants.newsButtonTitle)
        configureButton(randomButton, title: Constants.randomButtonTitle)
        configureButton(shuffleButton, title: Constants.shuffleButtonTitle)
        
        view.addSubview(stackView)
        stackView.alignment = .center
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.sideInsets)
            make.center.equalToSuperview()
        }
    }
    
    private func configureButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = Constants.conderRadius
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(Constants.buttonsHeight)
        }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        let destination = LibraryViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
}
