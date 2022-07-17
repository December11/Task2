//
//  SectionViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 13.07.2022.
//

import UIKit

final class SectionViewController: UIViewController {
    
    private enum Constants {
        static let sideInsets = 24.0
        static let spacing = 16.0
        
        static let booksButtonTitle = "Книги"
        static let newsButtonTitle = "Новости"
        static let randomButtonTitle = "Случайные"
        static let shuffleButtonTitle = "В перемешку"
    }
    
    private let bookButton = ButtonWithLoader()
    private let newsButton = ButtonWithLoader()
    private let randomButton = ButtonWithLoader()
    private let shuffleButton = ButtonWithLoader()
    
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
    
    private func configureButton(_ button: ButtonWithLoader, title: String) {
        button.title = title
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func fetchBooks(by sender: ButtonWithLoader) {
        FetchedDataService.shared.fetch { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                    sender.stopLoadAnimation()
                }
                
            case .success:
                DispatchQueue.main.async {
                    sender.stopLoadAnimation()
                    let destination = ContentListViewController()
                    self?.navigationController?.pushViewController(destination, animated: true)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        present(alertController, animated: true)
    }
    
    private func load(by sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        fetchBooks(by: sender)
    }
    
    @objc private func buttonAction(_ sender: ButtonWithLoader) {
        load(by: sender)
    }
    
}
