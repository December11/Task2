//
//  ViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import SnapKit
import UIKit

final class LibraryViewController: UIViewController {
    
    private enum Constants {
        static let cellIdentifier = "LibraryTableViewCell"
    }
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    private func configureUI() {
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureActivityIndicator()
    }
    
    private func update() {
        if BookService.shared.books.isEmpty {
            activityIndicator.startAnimating()
            fetchBooks()
        }
    }
    
    private func configureActivityIndicator() {
        activityIndicator.color = UIColor.systemGray2
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func fetchBooks() {
        BookService.shared.fetchBooks { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                    self?.activityIndicator.stopAnimating()
                }
                
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}

// MARK: UITableViewDataSource

extension LibraryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BookService.shared.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LibraryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard BookService.shared.books.indices.contains(indexPath.row) else { return UITableViewCell() }
        let currentBook = BookService.shared.books[indexPath.row]
        cell.configure(book: currentBook) { [weak self] in
            self?.showAlert(title: currentBook.authorName)
        }
        if indexPath.row == 0 {
            cell.separatorView.isHidden = true
        }
        
        return cell
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
}

// MARK: UITableViewDelegate

extension LibraryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    
}
