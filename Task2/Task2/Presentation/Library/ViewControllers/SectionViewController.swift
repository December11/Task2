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
        
        static let bookButtonTitle = "Книги"
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
        
        configureButton(bookButton, title: Constants.bookButtonTitle)
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
    
    private func fetchAndPush(service: FetchedDataService, at sender: ButtonWithLoader) {
        service.fetch { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                    sender.stopLoadAnimation()
                }
                
            case let .success(items):
                DispatchQueue.main.async {
                    sender.stopLoadAnimation()
                    let destination = ContentListViewController()
                    destination.content = items
                    self?.navigationController?.pushViewController(destination, animated: true)
                }
            }
        }
    }
    
    private func fetchData(
        service: FetchedDataService,
        at sender: ButtonWithLoader,
        completion: @escaping ([FetchedDataProtocol]) -> Void
    ) {
        service.fetch { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                    sender.stopLoadAnimation()
                }
                
            case let .success(items):
                completion(items)
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
        let fetchService = FetchedDataService(.books)
        fetchAndPush(service: fetchService, at: sender)
    }
    
    @objc private func newsButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        let fetchService = FetchedDataService(.news)
        fetchAndPush(service: fetchService, at: sender)
    }
    
    @objc private func randomButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        let fetchService = FetchedDataService(.randomCase())
        fetchAndPush(service: fetchService, at: sender)
    }
    
    @objc private func shuffleButtonAction(_ sender: ButtonWithLoader) {
        sender.startLoadAnimation()
        
        var books = [FetchedDataProtocol]()
        var news = [FetchedDataProtocol]()
        
        let dispatchGroup = DispatchGroup()
        
        let bookFetchWorkItem: DispatchWorkItem
        bookFetchWorkItem = DispatchWorkItem {
            dispatchGroup.enter()
            let fetchService = FetchedDataService(.books)
            self.fetchData(service: fetchService, at: sender) { items in
                books = items
                dispatchGroup.leave()
            }
        }
        bookFetchWorkItem.perform()
        
        let newsFetchWorkItem: DispatchWorkItem
        newsFetchWorkItem = DispatchWorkItem { 
            dispatchGroup.enter()
            let fetchService = FetchedDataService(.news)
            self.fetchData(service: fetchService, at: sender) { items in
                news = items
                dispatchGroup.leave()
            }
        }
        newsFetchWorkItem.perform()
        
        dispatchGroup.notify(queue: .main) {
            var items = [FetchedDataProtocol]()
            items.append(contentsOf: books)
            items.append(contentsOf: news)
            sender.stopLoadAnimation()
            
            let destination = ContentListViewController()
            destination.content = items.shuffled()
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
}
