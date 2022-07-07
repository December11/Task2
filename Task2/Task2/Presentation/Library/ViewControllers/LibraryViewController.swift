//
//  ViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import SnapKit
import UIKit

class LibraryViewController: UIViewController {
    private var books = [Book]()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getBooks()
        tableView.delegate = self
        tableView.dataSource = self
        configurateUI()
    }
    
    private func configurateUI() {
        tableView.register(LibraryCell.self, forCellReuseIdentifier: "LibraryCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configurateActivityIndicator()
    }
    
    private func configurateActivityIndicator() {
        activityIndicator.color = UIColor.systemGray2
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    private func getBooks() {
        BookService.shared.fetchBooks { [weak self] fetchedBooks in
            self?.books = fetchedBooks
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: UITableViewDataSource

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LibraryCell = tableView.dequeueReusableCell(for: indexPath)
        let currentBook = books[indexPath.row]
        cell.configurateCell(book: currentBook) { [weak self] in
            self?.showAlert(for: currentBook)
        }
        hideSeparatorIfLast(cell, for: indexPath)
        
        return cell
    }
    
    private func showAlert(for book: Book) {
        let alertController = UIAlertController(
            title: book.authorName,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        present(alertController, animated: true)
    }
    
    private func hideSeparatorIfLast(_ cell: UITableViewCell, for indexPath: IndexPath) {
        if indexPath.row == books.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        }
    }
}

// MARK: UITableViewDelegate

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
}
