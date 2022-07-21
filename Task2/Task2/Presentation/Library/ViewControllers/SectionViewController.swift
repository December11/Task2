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
        
        bookButton.addTarget(self, action: #selector(bookButtonAction), for: .touchUpInside)
        newsButton.addTarget(self, action: #selector(newsButtonAction), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(randomButtonAction), for: .touchUpInside)
        shuffleButton.addTarget(self, action: #selector(shuffleButtonAction), for: .touchUpInside)
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
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
    
    private func fetch(service fetchService: FetchedDataService, at sender: ButtonWithLoader) {
        fetchService.fetch { [weak self] result in
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
                    destination.content = fetchService.items
                    self?.navigationController?.pushViewController(destination, animated: true)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        present(alertController, animated: true)
    }
    
    @objc private func bookButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        let fetchService = FetchedDataService(service: .books)
        fetch(service: fetchService, at: sender)
    }
    
    @objc private func newsButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        let fetchService = FetchedDataService(service: .news)
        fetch(service: fetchService, at: sender)
    }
    
    @objc private func randomButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        let fetchService = FetchedDataService(service: .randomCase())
        fetch(service: fetchService, at: sender)
    }
    
    @objc private func shuffleButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        let fetchService = FetchedDataService(service: .books)
        fetch(service: fetchService, at: sender)
    }
    
}