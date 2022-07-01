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
        
        BookService.shared.getBooks { [weak self] fetchedBooks in
            self?.books = fetchedBooks
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LibraryCell.self, forCellReuseIdentifier: "LibraryCell")
        configurateUI()
    }
    
    private func configurateUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configurateActivityIndicator()
    }
    
    func configurateActivityIndicator() {
        activityIndicator.color = UIColor.systemGray2
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
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
        cell.configurateCell(name: currentBook.name, description: currentBook.description) { [weak self] in
            let alertController = UIAlertController(
                title: currentBook.authorName,
                message: "Author of the book",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Close", style: .default))
            self?.present(alertController, animated: true)
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
}
